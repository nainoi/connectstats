////////////////////////////////////////////////////////////////////////////////
// The following FIT Protocol software provided may be used with FIT protocol
// devices only and remains the copyrighted property of Dynastream Innovations Inc.
// The software is being provided on an "as-is" basis and as an accommodation,
// and therefore all warranties, representations, or guarantees of any kind
// (whether express, implied or statutory) including, without limitation,
// warranties of merchantability, non-infringement, or fitness for a particular
// purpose, are specifically disclaimed.
//
// Copyright 2017 Dynastream Innovations Inc.
////////////////////////////////////////////////////////////////////////////////
// ****WARNING****  This file is auto-generated!  Do NOT edit this file.
// Profile Version = 20.33Release
// Tag = production/akw/20.33.01-0-gdd6ece0
////////////////////////////////////////////////////////////////////////////////


#if !defined(FIT_TRAINING_FILE_MESG_HPP)
#define FIT_TRAINING_FILE_MESG_HPP

#include "fit_mesg.hpp"

namespace fit
{

class TrainingFileMesg : public Mesg
{
public:
    class FieldDefNum final
    {
    public:
       static const FIT_UINT8 Timestamp = 253;
       static const FIT_UINT8 Type = 0;
       static const FIT_UINT8 Manufacturer = 1;
       static const FIT_UINT8 Product = 2;
       static const FIT_UINT8 SerialNumber = 3;
       static const FIT_UINT8 TimeCreated = 4;
       static const FIT_UINT8 Invalid = FIT_FIELD_NUM_INVALID;
    };

    TrainingFileMesg(void) : Mesg(Profile::MESG_TRAINING_FILE)
    {
    }

    TrainingFileMesg(const Mesg &mesg) : Mesg(mesg)
    {
    }

    ///////////////////////////////////////////////////////////////////////
    // Checks the validity of timestamp field
    // Returns FIT_TRUE if field is valid
    ///////////////////////////////////////////////////////////////////////
    FIT_BOOL IsTimestampValid() const
    {
        const Field* field = GetField(253);
        if( FIT_NULL == field )
        {
            return FIT_FALSE;
        }

        return field->IsValueValid();
    }

    ///////////////////////////////////////////////////////////////////////
    // Returns timestamp field
    ///////////////////////////////////////////////////////////////////////
    FIT_DATE_TIME GetTimestamp(void) const
    {
        return GetFieldUINT32Value(253, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Set timestamp field
    ///////////////////////////////////////////////////////////////////////
    void SetTimestamp(FIT_DATE_TIME timestamp)
    {
        SetFieldUINT32Value(253, timestamp, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Checks the validity of type field
    // Returns FIT_TRUE if field is valid
    ///////////////////////////////////////////////////////////////////////
    FIT_BOOL IsTypeValid() const
    {
        const Field* field = GetField(0);
        if( FIT_NULL == field )
        {
            return FIT_FALSE;
        }

        return field->IsValueValid();
    }

    ///////////////////////////////////////////////////////////////////////
    // Returns type field
    ///////////////////////////////////////////////////////////////////////
    FIT_FILE GetType(void) const
    {
        return GetFieldENUMValue(0, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Set type field
    ///////////////////////////////////////////////////////////////////////
    void SetType(FIT_FILE type)
    {
        SetFieldENUMValue(0, type, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Checks the validity of manufacturer field
    // Returns FIT_TRUE if field is valid
    ///////////////////////////////////////////////////////////////////////
    FIT_BOOL IsManufacturerValid() const
    {
        const Field* field = GetField(1);
        if( FIT_NULL == field )
        {
            return FIT_FALSE;
        }

        return field->IsValueValid();
    }

    ///////////////////////////////////////////////////////////////////////
    // Returns manufacturer field
    ///////////////////////////////////////////////////////////////////////
    FIT_MANUFACTURER GetManufacturer(void) const
    {
        return GetFieldUINT16Value(1, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Set manufacturer field
    ///////////////////////////////////////////////////////////////////////
    void SetManufacturer(FIT_MANUFACTURER manufacturer)
    {
        SetFieldUINT16Value(1, manufacturer, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Checks the validity of product field
    // Returns FIT_TRUE if field is valid
    ///////////////////////////////////////////////////////////////////////
    FIT_BOOL IsProductValid() const
    {
        const Field* field = GetField(2);
        if( FIT_NULL == field )
        {
            return FIT_FALSE;
        }

        return field->IsValueValid();
    }

    ///////////////////////////////////////////////////////////////////////
    // Returns product field
    ///////////////////////////////////////////////////////////////////////
    FIT_UINT16 GetProduct(void) const
    {
        return GetFieldUINT16Value(2, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Set product field
    ///////////////////////////////////////////////////////////////////////
    void SetProduct(FIT_UINT16 product)
    {
        SetFieldUINT16Value(2, product, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Checks the validity of garmin_product field
    // Returns FIT_TRUE if field is valid
    ///////////////////////////////////////////////////////////////////////
    FIT_BOOL IsGarminProductValid() const
    {
        const Field* field = GetField(2);
        if( FIT_NULL == field )
        {
            return FIT_FALSE;
        }

        if( !CanSupportSubField( field, (FIT_UINT16) Profile::TRAINING_FILE_MESG_PRODUCT_FIELD_GARMIN_PRODUCT ) )
        {
            return FIT_FALSE;
        }

        return field->IsValueValid(0, (FIT_UINT16) Profile::TRAINING_FILE_MESG_PRODUCT_FIELD_GARMIN_PRODUCT);
    }


    ///////////////////////////////////////////////////////////////////////
    // Returns garmin_product field
    ///////////////////////////////////////////////////////////////////////
    FIT_GARMIN_PRODUCT GetGarminProduct(void) const
    {
        return GetFieldUINT16Value(2, 0, (FIT_UINT16) Profile::TRAINING_FILE_MESG_PRODUCT_FIELD_GARMIN_PRODUCT);
    }

    ///////////////////////////////////////////////////////////////////////
    // Set garmin_product field
    ///////////////////////////////////////////////////////////////////////
    void SetGarminProduct(FIT_GARMIN_PRODUCT garminProduct)
    {
        SetFieldUINT16Value(2, garminProduct, 0, (FIT_UINT16) Profile::TRAINING_FILE_MESG_PRODUCT_FIELD_GARMIN_PRODUCT);
    }

    ///////////////////////////////////////////////////////////////////////
    // Checks the validity of serial_number field
    // Returns FIT_TRUE if field is valid
    ///////////////////////////////////////////////////////////////////////
    FIT_BOOL IsSerialNumberValid() const
    {
        const Field* field = GetField(3);
        if( FIT_NULL == field )
        {
            return FIT_FALSE;
        }

        return field->IsValueValid();
    }

    ///////////////////////////////////////////////////////////////////////
    // Returns serial_number field
    ///////////////////////////////////////////////////////////////////////
    FIT_UINT32Z GetSerialNumber(void) const
    {
        return GetFieldUINT32ZValue(3, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Set serial_number field
    ///////////////////////////////////////////////////////////////////////
    void SetSerialNumber(FIT_UINT32Z serialNumber)
    {
        SetFieldUINT32ZValue(3, serialNumber, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Checks the validity of time_created field
    // Returns FIT_TRUE if field is valid
    ///////////////////////////////////////////////////////////////////////
    FIT_BOOL IsTimeCreatedValid() const
    {
        const Field* field = GetField(4);
        if( FIT_NULL == field )
        {
            return FIT_FALSE;
        }

        return field->IsValueValid();
    }

    ///////////////////////////////////////////////////////////////////////
    // Returns time_created field
    ///////////////////////////////////////////////////////////////////////
    FIT_DATE_TIME GetTimeCreated(void) const
    {
        return GetFieldUINT32Value(4, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

    ///////////////////////////////////////////////////////////////////////
    // Set time_created field
    ///////////////////////////////////////////////////////////////////////
    void SetTimeCreated(FIT_DATE_TIME timeCreated)
    {
        SetFieldUINT32Value(4, timeCreated, 0, FIT_SUBFIELD_INDEX_MAIN_FIELD);
    }

};

} // namespace fit

#endif // !defined(FIT_TRAINING_FILE_MESG_HPP)
