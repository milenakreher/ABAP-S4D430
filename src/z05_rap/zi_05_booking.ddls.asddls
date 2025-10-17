@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking'
define view entity ZI_05_Booking as select from ZR_05_Booking
association to parent ZI_05_Travel as _Travel
    on $projection.TravelId = _Travel.TravelId
{
    key TravelId,
    key BookingId,
    BookingDate,
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    FlightPrice,
    CurrencyCode,
    
    /* Associations */
    _Travel // Make association public
}
