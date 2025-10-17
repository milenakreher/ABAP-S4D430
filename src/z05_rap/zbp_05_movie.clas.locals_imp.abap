CLASS lhc_rating DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateRating FOR VALIDATE ON SAVE
      IMPORTING keys FOR Rating~validateRating.

ENDCLASS.

CLASS lhc_rating IMPLEMENTATION.

  METHOD validateRating.

    READ ENTITY IN LOCAL MODE ZI_05_Rating
    FIELDS ( rating ) WITH CORRESPONDING #( keys )
    RESULT FINAL(ratings).

    LOOP AT ratings INTO FINAL(rating).
      IF rating-Rating < 1 OR rating-Rating > 10.
        FINAL(message) = NEW zcm_054906_movie( textid = zcm_054906_movie=>co_invalid_rating
                                                  severity = if_abap_behv_message=>severity-error
                                                  rating = rating-Rating ).

        APPEND VALUE #( %tky = rating-%tky
                %msg = message
                %element = VALUE #( Rating = if_abap_behv=>mk-on ) ) TO reported-Rating.

        APPEND VALUE #( %tky = rating-%tky ) TO failed-rating.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_Movie DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Movie RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Movie RESULT result.

    METHODS validateGenre FOR VALIDATE ON SAVE
      IMPORTING keys FOR Movie~validateGenre.

    METHODS validatePublishingYear FOR VALIDATE ON SAVE
      IMPORTING keys FOR Movie~validatePublishingYear.

    METHODS rateMovie FOR MODIFY
      IMPORTING keys FOR ACTION Movie~rateMovie.

ENDCLASS.

CLASS lhc_Movie IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validateGenre.

    DATA movies TYPE TABLE FOR READ RESULT ZI_05_Movie\\Movie.
    DATA keys_for_read TYPE TABLE FOR READ IMPORT ZI_05_Movie\\Movie.

    keys_for_read = CORRESPONDING #( keys ).

    "Read Travels
    READ ENTITY IN LOCAL MODE ZI_05_Movie
        FIELDS ( Genre )
        WITH keys_for_read
        RESULT movies.

    "Process Travels
    LOOP AT movies INTO DATA(movie).

      "Validate Customer and Create Error Message
      SELECT SINGLE FROM ZI_05_GenreText
      FIELDS @abap_true
      WHERE text = @movie-Genre INTO @DATA(exists).

      IF exists = abap_false.
        DATA(message) = NEW zcm_054906_movie(
          textid      = zcm_054906_movie=>co_invalid_field_value
          severity    = if_abap_behv_message=>severity-error ).



        APPEND VALUE #( %tky = movie-%tky
                       %element = VALUE #( Genre = if_abap_behv=>mk-on )
                       %msg = message ) TO reported-movie.

        APPEND VALUE #( %tky = movie-%tky ) TO failed-movie.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validatePublishingYear.

    DATA movies TYPE TABLE FOR READ RESULT ZI_05_Movie\\Movie.
    DATA keys_for_read TYPE TABLE FOR READ IMPORT ZI_05_Movie\\Movie.

    keys_for_read = CORRESPONDING #( keys ).

    "Read Travels
    READ ENTITY IN LOCAL MODE ZI_05_Movie
        FIELDS ( PublishingYear )
        WITH keys_for_read
        RESULT movies.

    "Process Travels
    LOOP AT movies INTO DATA(movie).
      DATA current_year TYPE zabap_publishing_year.
      current_year = substring( len = 4 val = cl_abap_context_info=>get_system_date(  ) ).

      IF movie-PublishingYear > current_year.
        DATA(message) = NEW zcm_054906_movie(
          textid      = zcm_054906_movie=>co_invalid_publishing_year
          severity    = if_abap_behv_message=>severity-error ).



        APPEND VALUE #( %tky = movie-%tky
                       %element = VALUE #( PublishingYear = if_abap_behv=>mk-on )
                       %msg = message ) TO reported-movie.

        APPEND VALUE #( %tky = movie-%tky ) TO failed-movie.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD rateMovie.

    DATA user_name TYPE zabap_user_name.
    DATA rating TYPE zabap_rating.
    DATA rating_date TYPE zabap_rating_date.

    user_name = sy-uname.
    rating_date = cl_abap_context_info=>get_system_date( ).

    MODIFY ENTITY IN LOCAL MODE ZI_05_Movie
    CREATE BY \_Rating
    FIELDS ( UserName Rating RatingDate )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky %target = VALUE #( ( %cid = 'X'
                                                                            UserName = user_name
                                                                            RatingDate = rating_date
                                                                            Rating = key-%param-Rating ) ) ) ).

    READ ENTITY IN LOCAL MODE ZI_05_Movie
      BY \_Rating
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(ratings).


  ENDMETHOD.

ENDCLASS.
