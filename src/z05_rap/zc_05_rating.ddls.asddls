@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rating'
@Metadata.allowExtensions: true
define view entity ZC_05_Rating 
as projection on ZI_05_Rating
{
    key RatingUuid,
    MovieUuid,
    UserName,
    Rating,
    RatingDate,
    /* Associations */
    _Movie: redirected to parent ZC_05_Movie
}
