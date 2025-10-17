CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS validateCustomerId FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateCustomerId.

    METHODS determineStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR Travel~determineStatus.

    METHODS cancelTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~cancelTravel RESULT result.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validateCustomerId.

    DATA travels TYPE TABLE FOR READ RESULT ZI_05_Travel\\Travel.
    DATA keys_for_read TYPE TABLE FOR READ IMPORT ZI_05_Travel\\Travel.

    keys_for_read = CORRESPONDING #( keys ).

    "Read Travels
    READ ENTITY IN LOCAL MODE ZI_05_Travel
        FIELDS ( CustomerID )
        WITH keys_for_read
        RESULT travels.

    "Process Travels
    LOOP AT travels INTO DATA(travel).

      "Validate Customer and Create Error Message
      SELECT SINGLE FROM /dmo/customer
      FIELDS @abap_true
      WHERE customer_id = @travel-customerId INTO @DATA(exists).

      IF exists = abap_false.
        DATA(message) = NEW zcm_05_travel(
          textid      = zcm_05_travel=>invalid_customer_id
          severtiy    = if_abap_behv_message=>severity-error
           customer_id = travel-CustomerId ).



        APPEND VALUE #( %tky = travel-%tky
                       %element = VALUE #( CustomerId = if_abap_behv=>mk-on )
                       %msg = message ) TO reported-travel.

        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD determineStatus.


    MODIFY ENTITY IN LOCAL MODE ZI_05_Travel
        UPDATE FIELDS ( status )
        WITH VALUE #( FOR key IN keys ( %tky = key-%tky Status = 'N' ) ).

  ENDMETHOD.

  METHOD cancelTravel.
    DATA travels TYPE TABLE FOR READ RESULT ZI_05_Travel\\Travel.
    DATA keys_for_read TYPE TABLE FOR READ IMPORT ZI_05_Travel\\Travel.

    keys_for_read = CORRESPONDING #( keys ).

    "Read Travels
    READ ENTITY IN LOCAL MODE ZI_05_Travel
        ALL FIELDS
        WITH keys_for_read "With Corresponding #(keys)
        RESULT travels. "Result Data(travels).

    "Process Travels
    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).
      "Validate Status and Create Error Message
      IF <travel>-Status = 'X'.
        DATA(message) = NEW zcm_05_travel(
        textid = zcm_05_travel=>invalid_customer_id
        severtiy = if_abap_behv_message=>severity-error ).

        APPEND VALUE #( %tky = <travel>-%tky %msg = message %element = VALUE #( Status = if_abap_behv=>mk-on ) ) TO reported-travel.
        APPEND VALUE #( %tky = <travel>-%tky ) TO failed-travel.
        DELETE travels INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      "Set Status to 'X' and Create an Success Message
      <travel>-Status = 'X'.
      message = NEW zcm_05_travel(
    textid = zcm_05_travel=>invalid_customer_id
    severtiy = if_abap_behv_message=>severity-success ).

      APPEND VALUE #( %tky = <travel>-%tky %msg = message %element = VALUE #( Status = if_abap_behv=>mk-on ) ) TO reported-travel.


    ENDLOOP.

    "MOdify Travels
    MODIFY ENTITY IN LOCAL MODE ZI_05_Travel
    UPDATE FIELDS ( status )
    WITH VALUE #( FOR travel IN travels ( %tky = travel-%tky Status = travel-Status ) ).

    "Return Result
    result = VALUE #( FOR travel IN travels ( %tky = travel-%tky %param = travel ) ).

  ENDMETHOD.

ENDCLASS.
