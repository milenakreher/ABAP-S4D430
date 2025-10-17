@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_05_Movie as select from ZR_05_Movie
composition [0..*] of ZI_05_Rating as _Rating 
association [0..1] to ZI_05_AverageRating as _AverageRating on _AverageRating.MovieUuid = $projection.MovieUuid
association [0..1] to ZI_05_GenreText as _GenreText on _GenreText.value_low = $projection.Genre
association [1..1] to ZI_05_RuntimeText as _RuntimeText on _RuntimeText.RuntimeInMin = $projection.RuntimeInMin

{
    key MovieUuid,
    Title,
    Genre,
    PublishingYear,
    RuntimeInMin,
    ImageUrl,
    
          /* Transient Data */
      case when _AverageRating.AverageRating > 6.7 then 3
                  when _AverageRating.AverageRating between 3.4 and 6.7 then 2
                  when _AverageRating.AverageRating >0 then 1
                  else  0 end as  StatusCriticality,
    
     /* Admin Data */
    CreatedAt,
    CreatedBy,
    LastChangedAt,
    LastChangedBy,
    
    /* Assosiations*/
    _Rating,
    _AverageRating,
    _GenreText.text as GenreText,
    _RuntimeText
}
