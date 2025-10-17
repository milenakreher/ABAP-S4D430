@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rating'
define view entity ZI_05_Rating as select from ZR_05_Rating
association to parent ZI_05_Movie as _Movie
    on $projection.MovieUuid = _Movie.MovieUuid
{
    key RatingUuid,
    MovieUuid,
    UserName,
    Rating,
    RatingDate,
    _Movie // Make association public
}
