@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer with travels'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_CustomerWithTravels as select from ZR_05_Customer as Customer
 association [0..*] to   ZR_05_Travel     as _Travels on _Travels.CustomerId   = Customer.CustomerId
{
    key CustomerId,
    FirstName,
    LastName,
    Title,
    Street,
    PostalCode,
    City,
    
    /* Associations*/
    _Travels
}
