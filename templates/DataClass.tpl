<CODEGEN_FILENAME><StructureName>.dbl</CODEGEN_FILENAME>
<PROCESS_TEMPLATE>DataUtil</PROCESS_TEMPLATE>
;;******************************************************************************
;;WARNING: This file was created by CodeGen. Changes will be lost if regenerated
;;******************************************************************************

import System

namespace <NAMESPACE> 

    ;; Backing store for the public properties that expose the data
    .include "<STRUCTURE_NOALIAS>" repository, structure="str<StructureName>", end

    public class <StructureName> extends MarshalByRefObject

.region "Backing storage for properties"

        ;;Store a copy of the Synergy record
        private m<StructureName>, str<StructureName>

.endregion

.region "Constructors"

        ;;; <summary>
        ;;; Construct an empty <StructureName> object
        ;;; </summary>
        public method <StructureName>
            endparams
        proc
            init m<StructureName>
        endmethod

        ;;; <summary>
        ;;; Construct a <StructureName> object containing the data from a <STRUCTURE_NOALIAS> record
        ;;; </summary>
        ;;; <param name="a<StructureName>">Passed <StructureName> record (str<StructureName>)</param>
        internal method <StructureName>
            required in a<StructureName>, str<StructureName>
            endparams
        proc
            ;;Save the record
            m<StructureName> = a<StructureName>
        endmethod

.endregion

.region "Internal properties"

        ;;; <summary>
        ;;; Expose the full record (so it can be saved to a file, etc.)
        ;;; Only visible within the Synergy .NET assembly because other languages don't understand Synergy types
        ;;; </summary>
        internal property Record, str<StructureName>
            method get
            proc
                mreturn m<StructureName>
            endmethod
        endproperty

.endregion

.region "Public properties to expose individual fields"

        ;;Expose the fields in the Synergy record as properties, using .NET types

        <FIELD_LOOP>
        ;;; <summary>
        ;;; <FIELD_DESC> (<FIELD_NAME>, <FIELD_SPEC>)
        ;;; </summary>
        public property <FieldSqlName>, <FIELD_SNTYPE>
            method get
            proc
                <IF ALPHA>
                mreturn %atrim(m<StructureName>.<field_name>)
                </IF ALPHA>
                <IF DECIMAL>
                mreturn m<StructureName>.<field_name>
                </IF DECIMAL>
                <IF DATE_NULLABLE>
                <IF DATE>
                mreturn DataUtils.NullableDateFromDecimal(m<StructureName>.<field_name>)
                </IF DATE>
                <IF TIME>
                mreturn DataUtils.NullableTimeFromDecimal(m<StructureName>.<field_name>)
                </IF TIME>
                <ELSE>
                <IF DATE>
                mreturn DataUtils.DateFromDecimal(m<StructureName>.<field_name>)
                </IF DATE>
                <IF TIME>
                mreturn DataUtils.TimeFromDecimal(m<StructureName>.<field_name>)
                </IF TIME>
                </IF DATE_NULLABLE>
                <IF INTEGER>
                mreturn m<StructureName>.<field_name>
                </IF INTEGER>
                <IF USER>
                mreturn m<StructureName>.<field_name>
                </IF USER>
            endmethod
            method set
            proc
                <IF ALPHA>
                m<StructureName>.<field_name> = value
                </IF ALPHA>
                <IF DECIMAL>
                m<StructureName>.<field_name> = value
                </IF DECIMAL>
                <IF DATE_NULLABLE>
                <IF DATE_YYYYMMDD>
                m<StructureName>.<field_name> = DataUtils.D8FromNullableDate(value)
                </IF>
                <IF DATE_YYMMDD>
                m<StructureName>.<field_name> = DataUtils.D6FromNullableDate(value)
                </IF>
                <IF TIME_HHMMSS>
                m<StructureName>.<field_name> = DataUtils.D6FromNullableTime(value)
                </IF>
                <IF TIME_HHMM>
                m<StructureName>.<field_name> = DataUtils.D4FromNullableTime(value)
                </IF>
                <ELSE>
                <IF DATE_YYYYMMDD>
                m<StructureName>.<field_name> = DataUtils.D8FromDate(value)
                </IF>
                <IF DATE_YYMMDD>
                m<StructureName>.<field_name> = DataUtils.D6FromDate(value)
                </IF>
                <IF TIME_HHMMSS>
                m<StructureName>.<field_name> = DataUtils.D6FromTime(value)
                </IF>
                <IF TIME_HHMM>
                m<StructureName>.<field_name> = DataUtils.D4FromTime(value)
                </IF>
                </IF DATE_NULLABLE>
                <IF INTEGER>
                m<StructureName>.<field_name> = value
                </IF INTEGER>
                <IF USER>
                m<StructureName>.<field_name> = value
                </IF USER>
            endmethod
        endproperty

        </FIELD_LOOP>
.endregion

    endclass

endnamespace

                