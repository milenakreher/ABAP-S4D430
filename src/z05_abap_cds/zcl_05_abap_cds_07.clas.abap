CLASS zcl_05_abap_cds_07 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_abap_cds_07 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM ZI_05_CustomerWithTravels
       FIELDS FirstName, LastName, \_Travels-BeginDate, \_Travels-EndDate, \_Travels-Description
       WHERE city = 'Berlin'
       ORDER BY lastName ASCENDING, FirstName ASCENDING
       INTO TABLE @DATA(customers).

    out->write( customers ).

  ENDMETHOD.
ENDCLASS.
