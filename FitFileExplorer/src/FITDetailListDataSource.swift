//
//  FITFieldsListDataSource.swift
//  GarminConnect
//
//  Created by Brice Rosenzweig on 05/11/2016.
//  Copyright © 2016 Brice Rosenzweig. All rights reserved.
//

import Cocoa
import RZUtilsMacOS
import FitFileParser
import RZUtilsSwift

class FITDetailListDataSource: NSObject,NSTableViewDelegate,NSTableViewDataSource,RZTableViewDelegate {
    
    let selectionContext : FITSelectionContext
    var orderedKeys : [FitFieldKey] {
        return self.selectionContext.orderedKeys
    }
    
    var setupMode : Bool = false
    
    // Whether messages are in rows or columns
    var messageInColumns : Bool {
        get {
            self.selectionContext.messageInColumns
        }
        set {
            self.selectionContext.messageInColumns = newValue
        }
    }

    // MARK: - Indirection Convenience from Selection Context
    
    var selectedField : FitFieldKey? {
        get {
            return self.selectionContext.selectedField
        }
    }

    var fitFile : FitFile {
        return self.selectionContext.fitFile
    }
    var messages : [FitMessage] {
        return self.selectionContext.messages
    }
    var messageType :FitMessageType{
        get {
            return self.selectionContext.messageType
        }
    }
    
    init(context : FITSelectionContext) {
        self.selectionContext = context
        super.init()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    func requiredTableColumnsIdentifiers() -> [String] {
        if( self.messageInColumns){
            if self.messages.count == 1 {
                return [ "Field", "Value"]
            }else{
                var rv = [ "Field" ]
                for i in 0..<self.messages.count {
                    rv.append("message[\(i)]")
                }
                return rv
            }
        }else{
            return self.orderedKeys
        }
    }
    
    func tableView(_ tableView: NSTableView, sizeToFitWidthOfColumn column: Int) -> CGFloat {
        var width : CGFloat = 78.0
        let margin : CGFloat = 8.0
        
        guard
            let tableColumn = tableView.tableColumns[safe: column]
        else{
            return width
        }
        let selectionContext = self.selectionContext
        
        if( self.messageInColumns ){
            if column == 0 {
                for identifier in selectionContext.orderedKeys {
                    let display = selectionContext.display(field: identifier, messageType: selectionContext.messageType)
                    let fieldDisplay = selectionContext.attributedField(field: identifier, display: display)
                    width = max(width, fieldDisplay.size().width + margin)
                }
            }else {
                if let message = selectionContext.messages[safe: column-1] {
                    for identifier in selectionContext.orderedKeys {
                        if let value = message.interpretedField(key: identifier) {
                           let display = selectionContext.display(fieldValue: value, field: identifier)
                            let valueDisplay = selectionContext.attributedValue(field: identifier, display: display)
                            width = max(width,valueDisplay.size().width + margin)
                        }
                    }
                }
            }
        }else{
            let identifier = tableColumn.identifier.rawValue
            if let message = selectionContext.sampleMessage,
               let item = message.interpretedField(key:identifier){
                let display = selectionContext.display(fieldValue: item, field: identifier)
                let valueDisplay = selectionContext.attributedValue(field: identifier, display: display)
                width = max(width,valueDisplay.size().width + margin)
            }
        }
        return width
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if self.setupMode {
            return 0
        }
        if( self.messageInColumns){
            return self.selectionContext.orderedKeys.count
        }else{
            return Int(messages.count)
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard
            let cellView =  tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("MessageCellView"), owner: self) as? NSTableCellView,
            let tableColumn = tableColumn,
            let columnIndex = tableView.tableColumns.firstIndex(of: tableColumn)
        else {
            return nil
        }
        cellView.textField?.stringValue = ""
        
        let identifier = tableColumn.identifier.rawValue
        if( self.messageInColumns ){
            let selectionContext = self.selectionContext
            if identifier == "Field",
               let field = selectionContext.orderedKeys[safe: row] {
                let display = selectionContext.display(field: field, messageType: selectionContext.messageType)
                let fieldDisplay = selectionContext.attributedField(field: field, display: display)
                cellView.textField?.attributedStringValue = fieldDisplay
            }else if let message = self.messages[safe: columnIndex-1],
                     let field = selectionContext.orderedKeys[safe: row],
                     let value = message.interpretedField(key: field) {
                let display = selectionContext.display(fieldValue: value, field: field)
                let valueDisplay = selectionContext.attributedValue(field: field, display: display)
                cellView.textField?.attributedStringValue = valueDisplay
            }
        }else{
            if row < self.messages.count {
                let message = self.messages[row]
                if let value = message.interpretedField(key:identifier){
                    let display = selectionContext.display(fieldValue: value, field: identifier)
                    let valueDisplay = selectionContext.attributedValue(field: identifier, display: display)
                    cellView.textField?.attributedStringValue = valueDisplay
                }
            }
        }
        return cellView
    }
    
    func userClicked(_ tableView: RZTableView, row: Int, column: Int) {
        if self.messageInColumns {
            let selectedMessageIndex = column < 1 ? 0 : column - 1
            let fields = self.selectionContext.orderedKeys
            if let chosenField = fields[safe: row] {
                self.selectionContext.selectMessageField(field: chosenField, atIndex: selectedMessageIndex)
            }
        }else{
            if( column != -1 && column < tableView.tableColumns.count){
                if let chosenField = tableView.tableColumns[safe: column]?.identifier.rawValue {
                    self.selectionContext.selectMessageField(field: chosenField, atIndex: row)
                }
            }
        }
    }
    
}
