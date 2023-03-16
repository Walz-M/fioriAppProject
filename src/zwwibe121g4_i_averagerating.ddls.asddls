@EndUserText.label: 'Interface View: Average Rating'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZWWIBE121G4_I_AverageRating
  as select from zwwibe121g4_rat  as rat
    join         zwwibe121g4_proc as proc on rat.transaction_id = proc.transaction_id
{
  key proc.video_id                                                                  as VideoId,
      avg (cast(rat.rating as zwwibe121g4_video_rating) as zwwibe121g4_video_rating) as AvgRating
}
group by
  proc.video_id,
  rat.medium_id
