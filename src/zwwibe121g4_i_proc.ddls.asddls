@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View: rental process'

define view entity ZWWIBE121G4_I_PROC
  as select from zwwibe121g4_proc
  association        to parent ZWWIBE121G4_I_VID   as _Video        on $projection.VideoId = _Video.VideoId
  association [1..1] to ZWWIBE121G4_I_CustomerText as _CustomerText on $projection.CustomerId = _CustomerText.CustomerId
  association        to ZWWIBE121G4_I_MEDM         as _Medium       on $projection.MediumId = _Medium.MediumId
  composition [0..*] of ZWWIBE121G4_I_RAT          as _Rating
{
  key transaction_id     as TransactionId,
      @EndUserText: { label: 'Vorgangsnummer', quickInfo: 'Vorgangsnummer' }
      transaction_key    as TransactionKey,
      @EndUserText: { label: 'Kunde', quickInfo: 'Kunde' }
      @ObjectModel.text.element: ['CustomerName']
      customer_id        as CustomerId,
      video_id           as VideoId,
      medium_id          as MediumId,
      @EndUserText: { label: 'Ausleihdatum', quickInfo: 'Ausleihdatum' }
      loan_date          as LoanDate,
      @EndUserText: { label: 'Rückgabedatum', quickInfo: 'Rückgabedatum' }
      return_date        as ReturnDate,
      @EndUserText: { label: 'Leihgebühr', quickInfo: 'Leihgebühr' }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      lending_fee        as LendingFee,
      currency_code      as CurrencyCode,

      /* Associations */
      _Video,
      _Medium,
      _Rating,

      /* Transient Data */
      case when return_date = '00000000' then 2
           else 3
      end                as ReturnDateCriticality,
      _CustomerText.Name as CustomerName,
      _Video.Title       as VideoTitle


}
