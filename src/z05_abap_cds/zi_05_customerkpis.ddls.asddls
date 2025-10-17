@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer KPIS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_CustomerKPIs 
     with parameters
    P_City : /dmo/city

as select from Z05_I_TravelWithCustomer
{
    key CustomerId,
    CustomerName,
    Street,
    PostalCode,
    City,
    
       @Semantics.amount.currencyCode: 'NewCurrencyCode'
      sum(NewTotalPrice + NewBookingFee)    as TotalRevenue,

      NewCurrencyCode,
      avg(Duration as abap.dec(16,0)) as AverageDuration,
      count(distinct AgencyId)        as NumberOfDifferentAgencys
}
where City = $parameters.P_City

group by CustomerId,
    CustomerName,
    Street,
    PostalCode,
    City,
    NewCurrencyCode
    
 having sum(NewTotalPrice + NewBookingFee) > 5000 
