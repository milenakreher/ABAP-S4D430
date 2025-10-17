extend view entity ZI_05_Demo09 with 

association [1..1] to /dmo/carrier as _ZZCarrier on _ZZCarrier.carrier_id = $projection.CarrierId

{
    /dmo/connection.arrival_time as ZZArrivalTime,
    /dmo/connection.departure_time as ZZDepartureTime,
    
    _ZZCarrier
}
