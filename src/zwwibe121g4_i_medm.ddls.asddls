@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View: Medium'

define root view entity ZWWIBE121G4_I_MEDM
  as select from zwwibe121g4_medm
  composition [0..*] of ZWWIBE121G4_I_VID as _Videos
{
  key medium_id     as MediumId,
      @EndUserText: { label: 'Kosten pro Tag', quickInfo: 'Kosten pro Tag' }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      costs         as Costs,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH', element: 'Currency' } }]
      currency_code as CurrencyCode,
      medium        as Medium,

      /* Associations */
      _Videos
}
