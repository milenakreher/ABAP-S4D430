@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Travel'

@ObjectModel.usageType: { serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define root view entity ZI_05_Travel
  as select from ZR_05_Travel2
  
  composition [0..*] of ZI_05_Booking as _Bookings 
  association [1..1] to ZI_05_AgencyText as _AgencyText on _AgencyText.AgencyId = $projection.AgencyId
  association [1..1] to ZI_05_TotalBookingsByTravelId as _TotalBookings on _TotalBookings.TravelId = $projection.TravelId

{
  key TravelId,
  
      @ObjectModel.text.element: ['AgencyName']
      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,
      CurrencyCode,
      Description,
      Status,

      /* Transient Data */
      case Status when 'B' then 3
                  when 'P' then 2
                  when 'X' then 1
                  else 0 end as StatusCriticality,
                  
       /* Associations*/
      _AgencyText.Name as AgencyName, 
      _TotalBookings,
      _Bookings,
      

      /* Admin Data */
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat
}
