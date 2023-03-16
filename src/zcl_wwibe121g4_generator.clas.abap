CLASS zcl_wwibe121g4_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WWIBE121G4_GENERATOR IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

    data customer type zwwibe121g4_cust.
    data customers type table of zwwibe121g4_cust.

    customer-client = sy-mandt.
    customer-customer_id = 100400.
    customer-name = 'Tom Brady'.
    customer-date_of_accession = '20210911'.

    append customer to customers.

    customer-client = sy-mandt.
    customer-customer_id = 100500.
    customer-name = 'Leon Draisaitl'.
    customer-date_of_accession = '20190509'.

    append customer to customers.

    customer-client = sy-mandt.
    customer-customer_id = 100600.
    customer-name = 'Lebron James'.
    customer-date_of_accession = '20190905'.

    append customer to customers.

    customer-client = sy-mandt.
    customer-customer_id = 100700.
    customer-name = 'Usain Bolt'.
    customer-date_of_accession = '20230101'.

    append customer to customers.

    customer-client = sy-mandt.
    customer-customer_id = 100800.
    customer-name = 'Michael Phelps'.
    customer-date_of_accession = '20220405'.

    append customer to customers.

    customer-client = sy-mandt.
    customer-customer_id = 100900.
    customer-name = 'Andre Lange'.
    customer-date_of_accession = '20210706'.

    append customer to customers.

    customer-client = sy-mandt.
    customer-customer_id = 200000.
    customer-name = 'Mike Tyson'.
    customer-date_of_accession = '20230602'.

    append customer to customers.

    insert zwwibe121g4_cust FROM table @customers.

ENDMETHOD.
ENDCLASS.
