@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_05_Movie as select from zabap_movie_a
{
    key movie_uuid as MovieUuid,
    title as Title,
    genre as Genre,
    publishing_year as PublishingYear,
    runtime_in_min as RuntimeInMin,
    
    @Semantics.imageUrl:true
    image_url as ImageUrl,
    
     /* Admin Data */
    created_at as CreatedAt,
    @Semantics.user.createdBy:true
    created_by as CreatedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy
}
