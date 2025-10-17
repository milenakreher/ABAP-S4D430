@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Total Bookings by Travel Id'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_TotalBookingsByTravelId as select from /dmo/booking
{
    key travel_id as TravelId,
    
    @EndUserText.label: 'Number of Bookings'
    @EndUserText.quickInfo: 'Number of Bookings'
        count (*) as NoTotalBookings
}
group by
    travel_id
