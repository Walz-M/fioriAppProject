@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View: Video'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZWWIBE121G4_C_VID
  as projection on ZWWIBE121G4_I_VID
{
  key VideoId,
      VideoKey,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Title,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZWWIBE121G4_I_GENREVH', element: 'Genre' } }]
      Genre,
      PublishingYear,
      MediumId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZWWIBE121G4_I_STATUSVH', element: 'Status' } }]
      Status,
      StatusCriticality,
      AvgRating,
      AvgRatingCriticality,
      ImageUrl,

      /* Associations */
      _Medium          : redirected to parent ZWWIBE121G4_C_MEDM,
      _RentalProcesses : redirected to composition child ZWWIBE121G4_C_PROC,
      _Medium.Medium,
      _Medium.Costs,
      _Medium.CurrencyCode

}
