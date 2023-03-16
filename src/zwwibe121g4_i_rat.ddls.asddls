@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View: rating'
define view entity ZWWIBE121G4_I_RAT as select from zwwibe121g4_rat
association        to parent ZWWIBE121G4_I_PROC   as _RentalProcess        on $projection.TransactionId = _RentalProcess.TransactionId
association        to ZWWIBE121G4_I_MEDM         as _Medium       on $projection.MediumId = _Medium.MediumId
{
    key transaction_id as TransactionId,
    rating as Rating,
    medium_id as MediumId,
    
    
    /* Transient Data */
    
    case when cast(rating as abap.int1) < 4 and cast(rating as abap.int1) >= 0 then 1
         when cast(rating as abap.int1) < 7 and cast(rating as abap.int1) >= 4 then 2
         when cast (rating as abap.int1) <= 10 and cast(rating as abap.int1) >= 7 then 3
         else 0
      end           as RatingCriticality,
    
    _RentalProcess,
    _Medium
    
}
