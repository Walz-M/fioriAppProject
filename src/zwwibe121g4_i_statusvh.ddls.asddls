@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help: Status'

define view entity ZWWIBE121G4_I_STATUSVH as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZWWIBE121G4_STATUS' )
{

      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @UI.hidden: true
  key language,
   
    @EndUserText: { label: 'Status', quickInfo: 'Status' }
    value_low as Status
}
