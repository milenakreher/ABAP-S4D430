CLASS zcm_05_travel DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF invalid_customer_id,
        msgid TYPE symsgid VALUE 'Z05_TRAVEL',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE 'CUSTOMER_ID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_customer_id.

    DATA customer_id TYPE /dmo/customer_id.

    METHODS constructor
      IMPORTING
        !textid     LIKE if_t100_message=>t100key
        severtiy type if_abap_behv_message=>t_severity
        !previous   LIKE previous OPTIONAL
        customer_id TYPE /dmo/customer_id OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcm_05_travel IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).

  me->customer_id = customer_id.
  if_t100_message~t100key = textid.
  if_abap_behv_message~m_severity = severtiy.

  ENDMETHOD.


ENDCLASS.
