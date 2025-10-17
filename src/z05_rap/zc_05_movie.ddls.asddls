@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_05_Movie
  provider contract transactional_query
  as projection on ZI_05_Movie
{
  key MovieUuid,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Title,
      @ObjectModel.text.element: [ 'GenreText' ]
      @Consumption.valueHelpDefinition: [{ entity: {name: 'ZI_05_GenreVH', element: 'text' } }]
      Genre,
      PublishingYear,
      @ObjectModel.text.element: [ 'RuntimeText' ]
      RuntimeInMin,
      @Semantics.imageUrl: true
      ImageUrl,

      /* Transient Data */
      StatusCriticality,
      GenreText,
      _AverageRating.AverageRating as AverageRating,
      _RuntimeText.RuntimeText,

      /* Admin Data */
      CreatedAt,
      CreatedBy,
      LastChangedAt,
      LastChangedBy,

      /* Associations */
      _Rating : redirected to composition child ZC_05_Rating
}
