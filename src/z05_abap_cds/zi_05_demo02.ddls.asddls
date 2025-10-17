@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 2: Inner Joins'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_Demo02
  as select from /dmo/connection as Connection
    inner join   /dmo/flight     as Flight  on  Flight.carrier_id    = Connection.carrier_id
                                            and Flight.connection_id = Connection.connection_id

    inner join   /dmo/carrier    as Carrier on Carrier.carrier_id = Connection.carrier_id

{
  key Carrier.carrier_id            as CarrierId,
  key Connection.connection_id      as ConnectionId,
  key Flight.flight_date            as FlightDate,
      Carrier.name                  as Name,
      Connection.airport_from_id    as AirportFromId,
      Connection.airport_to_id      as AirportToId,
      Connection.departure_time     as DepartureTime,
      Connection.arrival_time       as ArrivalTime,
      @Semantics.amount.currencyCode: 'CurrencyCode2'
      Flight.price                  as Price,
      Flight.currency_code          as CurrencyCode2
}
