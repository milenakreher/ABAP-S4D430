@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 5: Aggregat Fuctions'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_Demo05
  as select from /dmo/flight
{
  key carrier_id                    as CarrierId,
      count(*)                      as NoTotalFlights,
      count(distinct plane_type_id) as NoPlaneTypeIds,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      sum(price)                    as TotalPrice,
      currency_code                 as CurrencyCode,

      min(seats_occupied)           as MinSeatsOccupied,
      max(seats_occupied)           as MaxSeatsOccupied,

      sum (case when (seats_occupied / seats_max ) > 0.7 then 1
      else 0 end)                   as NoAlmostBookedFlights,
      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      avg(price as abap.curr(16,2)) as AveragePrice
}

where price > 1000 

group by
  currency_code,
  carrier_id
  
 having sum(price) > 25000
