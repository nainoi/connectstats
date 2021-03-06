//
//  FITDataListDataSource.swift
//  GarminConnect
//
//  Created by Brice Rosenzweig on 25/05/2017.
//  Copyright © 2017 Brice Rosenzweig. All rights reserved.
//

import Cocoa
import RZUtilsMacOS
import FitFileParser



/*
 - Select Record or Lap or Session Field
 - Session/1 message -> find related fields or display field of message
 - display as table with line for each field
 - for each field-> Value, Avg, Min, Max
 - Surrounding Session or Lap (option)
 - for each field, map into other section where timestamp in [start_time/timestamp]:
 ex: speed -> session speed, session max speed, etc
 - Containing: Lap or Record
 - find record/lap (from start_time -> timestamp)
 - average/max from record.
 
 - Select Field in session:
 - find matching fields from record/lap, compute between start_time/timestamp:
 - avg, min, max
 - if nothing found: just display field
 
 - Compute Stats using: record/Lap for session/Lap/all
 - session: using record/lap for session/all
 - lap: using record for lap/session/all
 - record: using record for lap/session/all
 
 Calculated Value:
 - stat(avg/max/min) from record/lap for session/lap [surround field]
    operate on all messages within surround field
 - value/max/min from session/lap
    operate on the message that surround message
 - deriv/cumsum for session/lap
    operate on all prev sinc surround message: prev/curr+state (not next to simplify?)
 */
class FITDataListDataSource: NSObject,NSTableViewDelegate,NSTableViewDataSource {

    
    let selectionContext : FITSelectionContext
    
    var selectedField : FitFieldKey?
    var displayFields:[FitFieldKey]
    
    var statsMessageType:FitMessageType?
    var statsFields:[FitFieldKey:[FitFieldKey]]?
    var statistics:[FitFieldKey:FITFitValueStatistics]?
    
    var fitFile : FitFile {
        return self.selectionContext.fitFile
    }
    var messages:[FitMessage] {
        return self.selectionContext.messages
    }
    var messageType :FitMessageType{
        get {
            return self.selectionContext.messageType
        }
    }
    var message : FitMessage? {
        return self.selectionContext.message
    }
    
    
    init( context : FITSelectionContext) {
        self.selectionContext = context
        self.displayFields = []
        super.init()
    }
    
    func updateAfterMessageTypeChange() {
        let context = self.selectionContext
        let interp = context.interp
        let samplesKeys = context.orderedKeys
        
        // Session style, when fields are in columns.
        // Just select all fields that are related to selected field (max, avg, etc)
        if( context.messageInColumns ){
            if let field = context.selectedField {
                let mapped = interp.mapFields(from: [field], to:  samplesKeys)
        
                if let found = mapped[field] {
                    self.displayFields = found
                }else{
                    self.displayFields = [field]
                }
            }else{
                self.displayFields = [];
            }
        }else{
            // lap/record style when message are in rows: display all the field for the line
            self.displayFields = samplesKeys
        }
        // record could be session to get value or record to do stats
        let messageDefaultMap : [FitMessageType:FitMessageType] = [ .record : .record,
                                                                    .lap    : .record,
                                                                    .session: .record
                                ]
        
        self.statsMessageType = messageDefaultMap[context.messageType]
    }
    
    func updateStatistics(){
        let context = self.selectionContext
        if let statsUsing = context.statsUsing,
            let statsFor = context.statsFor{
            let interp = context.interp

            var interval : (from:Date,to:Date)?
            if let ts = context.message?.time(field: "timestamp"){
                
                let mf = interp.messageForTimestamp(messageType: statsFor, timestamp: ts)

                if let start = mf?.time(field: "start_time"),
                    let end = mf?.time(field: "timestamp"){
                    interval = (from:start,to:end);
                }
            }
            self.statistics = interp.statsForMessage(messageType: statsUsing, interval: interval)
            if let stats = self.statistics {
                let possibleFields = Array(stats.keys)
                self.statsFields = interp.mapFields(from: self.displayFields, to: possibleFields)
            }
        }
    }

    
    func requiredTableColumnsIdentifiers() -> [String] {
        return [ "Field", "Value"]
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.displayFields.count
    }
    
    func stringValue( identifier: String, field : String) -> String {
        if identifier == "field" {
            if let message = self.message {
                return self.selectionContext.display(field: field, messageType: message.messageType)
            }
        }else if(identifier == "value"){
            if let message = self.message,
               let item = message.interpretedField(key: field){
                return selectionContext.display(fieldValue: item, field: field)
            }
        }else{
            if let message = self.message,
               let item = message.interpretedField(key: field),
               let relatedFields = self.statsFields?[field],
               let stats = self.statistics {
                let stattype = FITFitValueStatistics.StatsType(rawValue: identifier) ?? FITFitValueStatistics.StatsType.avg
                
                if relatedFields.count > 0 && item.numberWithUnit != nil{
                    if let stat = stats[ relatedFields[0]]{
                        let preferred = stat.preferredStatisticsForField(fieldKey: field)
                        if preferred.contains(stattype) {
                            if let val : GCNumberWithUnit = stat.value(stats: stattype, field: field){
                                return selectionContext.display(numberWithUnit: val, field: field)
                            }
                        }
                    }
                }
            }
        }
        return ""
    }

    func tableView(_ tableView: NSTableView, sizeToFitWidthOfColumn column: Int) -> CGFloat {
        var width : CGFloat = 78
        let margin : CGFloat = 8.0
        guard
            let tableColumn = tableView.tableColumns[safe: column]
        else {
            return width
        }
        let identifier = tableColumn.identifier.rawValue

        for field in self.displayFields {
            let display = self.stringValue(identifier: identifier, field: field)
            let attrDisplay = selectionContext.attributedField(field: field, display: display)
            width = max(width, attrDisplay.size().width)
        }
        
        return width + margin
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard
            let cellView =  tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("DataCellView"), owner: self) as? NSTableCellView,
            let field = self.displayFields[safe: row],
            let identifier = tableColumn?.identifier.rawValue
        else {
            return nil
        }
        
        let display = self.stringValue(identifier: identifier, field: field)
        
        if identifier == "field" {
            cellView.textField?.attributedStringValue = selectionContext.attributedField(field: field, display: display)
        }else{
            cellView.textField?.attributedStringValue = selectionContext.attributedValue(field: field, display: display)
        }
        
        return cellView
    }
    

}
