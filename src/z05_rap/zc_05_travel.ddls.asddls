@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_05_Travel
  provider contract transactional_query as projection on ZI_05_Travel
{
    key TravelId,
    AgencyId,
    
   @Consumption.valueHelpDefinition: [{ entity: {name: 'ZI_05_CustomerVH', element: 'CustomerId' } }]
    CustomerId,
    BeginDate,
    EndDate,
    BookingFee,
    TotalPrice,
    
    @Consumption.valueHelpDefinition: [{ entity: {name: 'I_CurrencyStdVH', element: 'Currency' } }]
    CurrencyCode,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    Description,
    Status,
    
    /* Transient Data */
    StatusCriticality, 
    AgencyName,
    _TotalBookings.NoTotalBookings, 
    
    /* Admin Data */
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    
    /* Associations */
    _Bookings: redirected to composition child ZC_05_Booking
}
