CLASS zcl_05_demo_11 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_demo_11 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM ZI_05_Demo06( p_carrierid = 'LH' )
      FIELDS *
*      WHERE CarrierId = 'LH'
      INTO TABLE @DATA(flights).

    out->write( flights ).


  ENDMETHOD.
ENDCLASS.
