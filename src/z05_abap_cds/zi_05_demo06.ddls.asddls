@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 6: Views with Parameters'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_Demo06
  with parameters
    P_CarrierId  : /dmo/carrier_id,
    @Environment.systemField: #USER_DATE
    P_TargetDate : abap.dats

  as select from /dmo/flight

{
  key carrier_id     as CarrierId,
  key connection_id  as ConnectionId,
  key flight_date    as FlightDate,
      price          as Price,
      currency_code  as CurrencyCode,
      plane_type_id  as PlaneTypeId,
      seats_max      as SeatsMax,
      seats_occupied as SeatsOccupied
}
where
  carrier_id = $parameters.P_CarrierId
 and flight_date > $parameters.P_TargetDate 
