@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text: Customer'
define view entity ZWWIBE121G4_I_CustomerText as select from zwwibe121g4_cust
{

        @EndUserText: { label: 'Kundennummer', quickInfo: 'Kundennummer' }
        key customer_id as CustomerId,
        @EndUserText: { label: 'Name', quickInfo: 'Name' }
        name as Name,
        @EndUserText: { label: 'Beitrittsdatum', quickInfo: 'Beitrittsdatum' }
        date_of_accession as DateOfAccession

}
