CLASS zcm_121g4_video DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  "Types
    TYPES ty_user TYPE c LENGTH 12.

    "Interfaces
    INTERFACES if_abap_behv_message.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    "Message Constants
    CONSTANTS:
      BEGIN OF button_was_pressed,
        msgid TYPE symsgid VALUE 'ZWWIBE121G4_UI_VIDEO',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'USER',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF button_was_pressed.

    "Attributs
    DATA user TYPE ty_user.

    "Constructor
    METHODS constructor
      IMPORTING
        severity TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        textid   LIKE if_t100_message=>t100key DEFAULT if_t100_message=>default_textid
        previous LIKE previous OPTIONAL
        user     TYPE ty_user OPTIONAL.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcm_121g4_video IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    if_t100_message~t100key = textid.
    me->if_abap_behv_message~m_severity = severity.
    me->user = user.
  ENDMETHOD.


ENDCLASS.
