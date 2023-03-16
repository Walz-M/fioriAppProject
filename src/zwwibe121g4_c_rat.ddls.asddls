@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View: rating'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZWWIBE121G4_C_RAT
  as projection on ZWWIBE121G4_I_RAT
{
      @Search.defaultSearchElement: true
  key TransactionId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZWWIBE121G4_I_RatingVH', element: 'Rating' } }]
      Rating,
      MediumId,
      RatingCriticality,


      /* Associations */
      _RentalProcess : redirected to parent ZWWIBE121G4_C_PROC,
      _Medium        : redirected to ZWWIBE121G4_C_MEDM,
      @EndUserText: { label: 'Kunde', quickInfo: 'Kunde' }
      _RentalProcess.CustomerName,
      @EndUserText: { label: 'Video', quickInfo: 'Video' }
      _RentalProcess.VideoTitle
      
}
