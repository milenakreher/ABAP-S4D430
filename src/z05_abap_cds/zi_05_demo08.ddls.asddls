@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 8: Path Expressions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_Demo08 as select from ZI_05_DEMO07
{
    key CarrierId,
    key ConnectionId,
    AirportFromId,
    AirportToId,
    DepartureTime,
    ArrivalTime,
    _Carrier.name as CarrierName, 
    
    /* Associations */
    _Flights
}
