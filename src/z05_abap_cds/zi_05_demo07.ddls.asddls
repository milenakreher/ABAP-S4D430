@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 7: Associations'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_DEMO07
  as select from /dmo/connection as Connection
    association [0..*] to   /dmo/flight     as _Flights  on  _Flights.carrier_id    = Connection.carrier_id
                                            and _Flights.connection_id = Connection.connection_id

    association [1..1] to   /dmo/carrier    as _Carrier on _Carrier.carrier_id = Connection.carrier_id

{
  key Connection.carrier_id            as CarrierId,
  key Connection.connection_id      as ConnectionId,
      Connection.airport_from_id    as AirportFromId,
      Connection.airport_to_id      as AirportToId,
      Connection.departure_time     as DepartureTime,
      Connection.arrival_time       as ArrivalTime,
      
      /* Associations */
      _Flights,
      _Carrier
      
 }
