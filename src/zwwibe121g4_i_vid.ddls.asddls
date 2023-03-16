@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View: Video'

define view entity ZWWIBE121G4_I_VID
 as select from zwwibe121g4_vid
  association to parent ZWWIBE121G4_I_MEDM as _Medium on $projection.MediumId = _Medium.MediumId
  association [1..1] to ZWWIBE121G4_I_AverageRating   as _AverageRating   on $projection.VideoId = _AverageRating.VideoId
 composition [0..*] of ZWWIBE121G4_I_PROC as _RentalProcesses
{
    key video_id as VideoId,
    video_key as VideoKey,
    @EndUserText: { label: 'Titel', quickInfo: 'Titel' }
    title as Title,
    genre as Genre,
    @EndUserText: { label: 'Erscheinungsjahr', quickInfo: 'Erscheinungsjahr' }
    publishing_year as PublishingYear,
    medium_id as MediumId,
    status as Status,
    @EndUserText: { label: 'Bild URL', quickInfo: 'Bild URL' }
    @Semantics.imageUrl: true
    image_url as ImageUrl,
    
    /* Associations */
    _Medium,
    _RentalProcesses,
    
    /* Transient Data */
      case status when 'VERFÜGBAR' then 3
                  when 'VERLIEHEN' then 1
                  else 0
      end           as StatusCriticality,
      
      case when _AverageRating.AvgRating < 4.0 then 1
           when _AverageRating.AvgRating < 7.0 and _AverageRating.AvgRating >= 4.0 then 2
           when _AverageRating.AvgRating <= 10.0 and _AverageRating.AvgRating >= 7.0 then 3
           else 0
      end           as AvgRatingCriticality,
      
      @EndUserText: { label: 'Durchschnittsbewertung', quickInfo: 'Durchschnittsbewertung' }
      _AverageRating.AvgRating
}
