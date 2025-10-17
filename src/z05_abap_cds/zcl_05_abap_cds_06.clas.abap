CLASS zcl_05_abap_cds_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_abap_cds_06 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

   SELECT FROM ZI_05_CUSTOMERKPIS( P_city = 'Berlin' )
      FIELDS *
*      WHERE CarrierId = 'LH'
        ORDER BY TotalRevenue DESCENDING
      INTO TABLE @DATA(customers).

    out->write( customers ).


  ENDMETHOD.
ENDCLASS.
