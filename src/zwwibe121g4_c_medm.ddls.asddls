@EndUserText.label: 'Projection View: Medium'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZWWIBE121G4_C_MEDM
  provider contract transactional_query
  as projection on ZWWIBE121G4_I_MEDM
{
  key MediumId,
      Costs,
      CurrencyCode,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Medium,

      /* Associations */
      _Videos : redirected to composition child ZWWIBE121G4_C_VID
}
