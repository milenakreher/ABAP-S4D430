@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rating'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_05_Rating
  as select from zabap_rating_a
{
  key rating_uuid as RatingUuid,
      movie_uuid  as MovieUuid,
      user_name   as UserName,
      rating      as Rating,
      rating_date as RatingDate
}
