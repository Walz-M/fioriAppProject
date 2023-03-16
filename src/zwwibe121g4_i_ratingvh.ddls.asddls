@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help: Rating'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZWWIBE121G4_I_RatingVH as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZWWIBE121G4_DEC' )
{
  @UI.hidden: true
  key domain_name,
  @UI.hidden: true
  key value_position,
  @UI.hidden: true
  key language,
   
  @EndUserText: { label: 'Rating', quickInfo: 'Rating' }
  value_low as Rating
}
