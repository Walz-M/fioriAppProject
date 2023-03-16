CLASS lhc_rating DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateRating FOR VALIDATE ON SAVE
      IMPORTING keys FOR rating~validateRating.

ENDCLASS.

CLASS lhc_rating IMPLEMENTATION.

  METHOD validateRating.

    READ ENTITY IN LOCAL MODE zwwibe121g4_i_rat
     FIELDS ( Rating )
     WITH CORRESPONDING #( keys )
     RESULT Data(ratings).

        LOOP AT ratings into data(rating).

            if rating-Rating < 0 OR rating-Rating > 10.
                INSERT VALUE #( %tky = rating-%tky ) INTO TABLE failed-rental.

                INSERT VALUE #(
                %tky = rating-%tky
                %msg = new_message_with_text( text = 'Rating muss zwischen 0 und 10 liegen' )
                %element-CustomerId = if_abap_behv=>mk-on
                ) INTO TABLE reported-rental.

        ENDIF.

     ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZWWIBE121G4_I_MEDM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Medium RESULT result.
    METHODS validatemedium FOR VALIDATE ON SAVE
      IMPORTING keys FOR medium~validatemedium.

ENDCLASS.

CLASS lhc_ZWWIBE121G4_I_MEDM IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validateMedium.

  READ ENTITY IN LOCAL MODE ZWWIBE121G4_I_MEDM
     FIELDS ( Costs )
     WITH CORRESPONDING #( keys )
     RESULT Data(media).

     LOOP AT media into data(medium).

     IF medium-Costs <= 0.

        INSERT VALUE #( %tky = medium-%tky ) INTO TABLE failed-medium.

                INSERT VALUE #(
                %tky = medium-%tky
                %msg = new_message_with_text( text = 'Die Kosten pro Tag müssen größer 0 sein' )
                %element-CustomerId = if_abap_behv=>mk-on
                ) INTO TABLE reported-rental.

        ENDIF.

     ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZWWIBE121G4_I_VID DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR rental RESULT result.

    METHODS return_video FOR MODIFY
      IMPORTING keys FOR ACTION rental~return_video.

    METHODS determinelending FOR DETERMINE ON save
      IMPORTING keys FOR rental~determineLending.
    METHODS determineVideo FOR DETERMINE ON SAVE
      IMPORTING keys FOR video~determineVideo.
    METHODS determineTransactionKey FOR DETERMINE ON SAVE
      IMPORTING keys FOR rental~determineTransactionKey.
    METHODS determineDate FOR DETERMINE ON SAVE
      IMPORTING keys FOR rental~determineDate.
    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR rental~validateCustomer.
    METHODS validateGenre FOR VALIDATE ON SAVE
      IMPORTING keys FOR video~validateGenre.


ENDCLASS.

CLASS lhc_ZWWIBE121G4_I_VID IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD return_video.

"Deklarationen
    DATA rentals TYPE TABLE FOR READ RESULT ZWWIBE121G4_I_PROC.

    "Lesen der Daten
    READ ENTITY IN LOCAL MODE ZWWIBE121G4_I_PROC
      BY \_Video
      FIELDS ( Status VideoId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(videos)

     FIELDS ( VideoId ReturnDate )
     WITH CORRESPONDING #( keys )
     RESULT rentals.

     READ ENTITY IN LOCAL MODE ZWWIBE121G4_I_PROC
      BY \_Medium
      FIELDS ( Costs )
      WITH CORRESPONDING #( keys )
      RESULT DATA(mediums)

    FIELDS ( VideoId LendingFee LoanDate ReturnDate )
     WITH CORRESPONDING #( keys )
     RESULT rentals.

    LOOP AT rentals INTO DATA(rental).

    DATA(video) = videos[ 1 ].
    DATA(medium) = mediums[ 1 ].

     IF video-Status = 'VERFÜGBAR' OR rental-ReturnDate <> '00000000'.

                INSERT VALUE #( %tky = rental-%tky ) INTO TABLE failed-rental.

                INSERT VALUE #(
                %tky = rental-%tky
                %msg = new_message_with_text( text = 'Video ist bereits zurückgegeben oder verfügbar' )
                %element-TransactionKey = if_abap_behv=>mk-on
                ) INTO TABLE reported-rental.

    APPEND CORRESPONDING #( video ) TO failed-video.

    Continue.

    ELSEIF video-Status = 'VERLIEHEN'.


    MODIFY ENTITY IN LOCAL MODE ZWWIBE121G4_I_VID
     UPDATE FIELDS ( Status )
        WITH VALUE #( ( %tky = video-%tky Status = 'VERFÜGBAR' ) ).

    MODIFY ENTITY IN LOCAL MODE ZWWIBE121G4_I_PROC
    UPDATE FIELDS ( ReturnDate )
        with Value #( ( %tky = rental-%tky ReturnDate = sy-datum ) ).

    MODIFY ENTITY IN LOCAL MODE ZWWIBE121G4_I_PROC
    UPDATE FIELDS ( LendingFee )
        with Value #( ( %tky = rental-%tky LendingFee = ( ( sy-datum + 1 ) - rental-LoanDate ) * medium-Costs ) ).


    ENDIF.
    ENDLOOP.

  ENDMETHOD.



  METHOD determineLending.

 "Deklarationen
    DATA rentals TYPE TABLE FOR READ RESULT ZWWIBE121G4_I_PROC.

    "Lesen der Daten
    READ ENTITY IN LOCAL MODE ZWWIBE121G4_I_PROC
      BY \_Video
      FIELDS ( Status VideoId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(videos)


     FIELDS ( VideoId LendingFee LoanDate ReturnDate )
     WITH CORRESPONDING #( keys )
     RESULT rentals.

    LOOP AT rentals INTO DATA(rental).

    DATA(video) = videos[ 1 ].

    IF video-Status = 'VERLIEHEN'.

    DATA tmp TYPE c LENGTH 12.
        tmp = video-VideoKey.

    DATA(message) = NEW zcm_121G4_video( severity = if_abap_behv_message=>severity-error
          textid   = zcm_121G4_video=>button_was_pressed
          user     = tmp ).

    APPEND message TO reported-%other.

    Continue.

    ELSEIF video-Status = 'VERFÜGBAR'.

    MODIFY ENTITY IN LOCAL MODE ZWWIBE121G4_I_VID
        UPDATE FIELDS ( Status )
        WITH VALUE #( ( %tky = video-%tky Status = 'VERLIEHEN' ) ).

    ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD determineVideo.

  READ ENTITY IN LOCAL MODE ZWWIBE121G4_I_VID
      FIELDS ( Status VideoKey )
      WITH CORRESPONDING #( keys )
      RESULT DATA(Videos).

  LOOP AT videos INTO DATA(video).

        SELECT SINGLE FROM ZWWIBE121G4_I_VID
        FIELDS MAX( VideoKey ) AS max_video_key
        INTO @DATA(max_video_key).

        MODIFY ENTITY IN LOCAL MODE ZWWIBE121G4_I_VID
        UPDATE FIELDS ( Status VideoKey )
        WITH VALUE #( ( %tky = video-%tky Status = 'VERFÜGBAR' VideoKey = max_video_key + 1 ) ).


  ENDLOOP.

  ENDMETHOD.

  METHOD determineTransactionKey.

  READ ENTITY IN LOCAL MODE ZWWIBE121G4_I_PROC
     FIELDS ( TransactionKey )
     WITH CORRESPONDING #( keys )
     RESULT DATA(rentals).

  LOOP AT rentals INTO DATA(rental).
    SELECT SINGLE FROM ZWWIBE121G4_I_PROC
        FIELDS MAX( TransactionKey ) AS max_transaction_key
        INTO @DATA(max_transaction_key).

    MODIFY ENTITY IN LOCAL MODE ZWWIBE121G4_I_PROC
        UPDATE FIELDS ( TransactionKey )
        WITH VALUE #( ( %tky = rental-%tky TransactionKey = max_transaction_key + 1 ) ).

  ENDLOOP.

  ENDMETHOD.


  METHOD determineDate.

  READ ENTITY IN LOCAL MODE ZWWIBE121G4_I_PROC
     FIELDS ( LoanDate )
     WITH CORRESPONDING #( keys )
     RESULT DATA(rentals).

    LOOP AT rentals INTO DATA(rental).

    MODIFY ENTITY IN LOCAL MODE ZWWIBE121G4_I_PROC
        UPDATE FIELDS ( LoanDate )
        WITH VALUE #( ( %tky = rental-%tky LoanDate = sy-datum ) ).

    ENDLOOP.
  ENDMETHOD.

  METHOD validateCustomer.

  READ ENTITY IN LOCAL MODE ZWWIBE121G4_I_PROC
     FIELDS ( CustomerId )
     WITH CORRESPONDING #( keys )
     RESULT DATA(rentals)
     FAILED DATA(cst_failed)
     REPORTED DATA(cst_reported).

     LOOP AT rentals INTO DATA(rental).

        SELECT SINGLE FROM zwwibe121g4_cust
            FIELDS customer_id
            WHERE customer_id = @rental-CustomerId
            INTO @DATA(found_customerId).

        IF sy-subrc <> 0.
            INSERT VALUE #( %tky = rental-%tky ) INTO TABLE failed-rental.

            INSERT VALUE #(
             %tky = rental-%tky
             %msg = new_message_with_text( text = 'Kunde wurde nicht gefunden' )
            %element-CustomerId = if_abap_behv=>mk-on
            ) INTO TABLE reported-rental.
        ENDIF.

     ENDLOOP.

  ENDMETHOD.

  METHOD validateGenre.

  READ ENTITY IN LOCAL MODE ZWWIBE121G4_I_VID
     FIELDS ( Genre )
     WITH CORRESPONDING #( keys )
     RESULT DATA(videos)
     FAILED DATA(vid_failed)
     REPORTED DATA(vid_reported).

     LOOP AT videos INTO DATA(video).

        SELECT SINGLE FROM ZWWIBE121G4_I_GENREVH
            FIELDS Genre
            WHERE Genre = @video-Genre
            INTO @DATA(found_genre).

        IF sy-subrc <> 0.
            INSERT VALUE #( %tky = video-%tky ) INTO TABLE failed-video.

            INSERT VALUE #(
             %tky = video-%tky
             %msg = new_message_with_text( text = 'Genre wurde nicht gefunden' )
            %element-Genre = if_abap_behv=>mk-on
            ) INTO TABLE reported-video.
        ENDIF.

     ENDLOOP.

  ENDMETHOD.

ENDCLASS.
