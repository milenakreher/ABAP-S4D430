CLASS zcl_05_demo_10 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_demo_10 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM /DMO/C_Travel_Approver_M
      FIELDS *
      WHERE agencyId = '070041'
      INTO TABLE @DATA(travel_approvers).

    out->write( travel_approvers ).

  ENDMETHOD.
ENDCLASS.
