CLASS zcl_05_demo_12 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_demo_12 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA customers TYPE TABLE OF /dmo/customer.

    SELECT FROM /dmo/customer
    FIELDS *
    INTO TABLE @customers.

    LOOP AT customers INTO DATA(customer).

      AUTHORITY-CHECK OBJECT '/dmo/TRVL'
      ID '/DMO/CNTRY' FIELD customer-country_code
      ID 'Actvt' FIELD '03'.
      IF sy-subrc <> 0.
        DELETE customers INDEX sy-tabix.
      ENDIF.

    ENDLOOP.

    out->write( lines( customers ) ).
    out->write( customers ).

  ENDMETHOD.
ENDCLASS.
