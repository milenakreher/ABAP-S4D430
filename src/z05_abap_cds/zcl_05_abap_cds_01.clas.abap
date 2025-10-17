CLASS zcl_05_abap_cds_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_abap_cds_01 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  select from /DMO/C_Booking_Approver_M
  fields *
  where connectionID = '0400'
   INTO TABLE @DATA(booking_approvers).

    out->write( booking_approvers ).


  ENDMETHOD.
ENDCLASS.
