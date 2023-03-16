@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View: rental process'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZWWIBE121G4_C_PROC
  as projection on ZWWIBE121G4_I_PROC
{
  key TransactionId,
      TransactionKey,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZWWIBE121G4_I_CustomerVH', element: 'CustomerId' } }]
      CustomerId,
      @Search.defaultSearchElement: true
      VideoId,
      MediumId,
      LoanDate,
      ReturnDate,
      LendingFee,
      CurrencyCode,
      ReturnDateCriticality,
      CustomerName,
      VideoTitle,

      /* Associations */
      _Video  : redirected to parent ZWWIBE121G4_C_VID,
      _Medium : redirected to ZWWIBE121G4_C_MEDM,
      _Rating : redirected to composition child ZWWIBE121G4_C_RAT,
      @EndUserText: { label: 'Video', quickInfo: 'Video' }
      @ObjectModel.text.element: ['VideoTitle']
      _Video.VideoKey

}
