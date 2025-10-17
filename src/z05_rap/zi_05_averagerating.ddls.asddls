@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Average Rating'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_AverageRating as select from zabap_rating_a
{
    key movie_uuid as MovieUuid,

    @EndUserText.label: 'Average Rating'
    @EndUserText.quickInfo: 'Average Rating'
        avg(rating as abap.dec( 16, 1 )) as AverageRating
}
group by
    movie_uuid
