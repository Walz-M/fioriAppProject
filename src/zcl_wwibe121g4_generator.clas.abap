CLASS zcl_wwibe121g4_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_wwibe121g4_generator IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA customer TYPE zwwibe121g4_cust.
    DATA customers TYPE TABLE OF zwwibe121g4_cust.

    customer-client = sy-mandt.
    customer-customer_id = 100400.
    customer-name = 'Tom Brady'.
    customer-date_of_accession = '20210911'.

    APPEND customer TO customers.

    customer-client = sy-mandt.
    customer-customer_id = 100500.
    customer-name = 'Leon Draisaitl'.
    customer-date_of_accession = '20190509'.

    APPEND customer TO customers.

    customer-client = sy-mandt.
    customer-customer_id = 100600.
    customer-name = 'Lebron James'.
    customer-date_of_accession = '20190905'.

    APPEND customer TO customers.

    customer-client = sy-mandt.
    customer-customer_id = 100700.
    customer-name = 'Usain Bolt'.
    customer-date_of_accession = '20230101'.

    APPEND customer TO customers.

    customer-client = sy-mandt.
    customer-customer_id = 100800.
    customer-name = 'Michael Phelps'.
    customer-date_of_accession = '20220405'.

    APPEND customer TO customers.

    customer-client = sy-mandt.
    customer-customer_id = 100900.
    customer-name = 'Andre Lange'.
    customer-date_of_accession = '20210706'.

    APPEND customer TO customers.

    customer-client = sy-mandt.
    customer-customer_id = 200000.
    customer-name = 'Mike Tyson'.
    customer-date_of_accession = '20230602'.

    APPEND customer TO customers.

    INSERT zwwibe121g4_cust FROM TABLE @customers.

  ENDMETHOD.
ENDCLASS.
