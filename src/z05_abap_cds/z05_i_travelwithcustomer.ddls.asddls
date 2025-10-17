@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel with Customer'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z05_I_TravelWithCustomer
  as select from ZR_05_Customer                                              as Customer
    inner join   ZR_05_Travel                                                as Travel     on Travel.CustomerId = Customer.CustomerId
    inner join   DDCDS_CUSTOMER_DOMAIN_VALUE_T(p_domain_name: '/DMO/STATUS') as TextStatus on  TextStatus.value_low = Travel.Status
                                                                                           and TextStatus.language  = $session.system_language
{
  key Travel.TravelId,
      Travel.CustomerId,
      Travel.AgencyId,
      Travel.BeginDate,
      Travel.EndDate,

      @EndUserText.label:'Duration in Days'
      @EndUserText.quickInfo:'Duration in Days'
      dats_days_between(Travel.BeginDate, Travel.EndDate ) + 1 as Duration,

      @Semantics.amount.currencyCode: 'NewCurrencyCode'

      currency_conversion( amount => Travel.BookingFee,
      source_currency => Travel.CurrencyCode,
       target_currency => $projection.NewCurrencyCode,
        exchange_rate_date => $session.system_date )           as NewBookingFee,

      cast('EUR' as abap.cuky( 5 ) )                           as NewCurrencyCode,


      @Semantics.amount.currencyCode: 'NewCurrencyCode2'
      currency_conversion( amount => Travel.TotalPrice,
      source_currency => Travel.CurrencyCode,
      target_currency => $projection.NewCurrencyCode,
       exchange_rate_date => $session.system_date )            as NewTotalPrice,

      cast('EUR' as abap.cuky( 5 ) )                           as NewCurrencyCode2,

      Travel.Description,
      Travel.Status,
      TextStatus.text,

      @EndUserText.label:'Customer Name'
      @EndUserText.quickInfo:'Customer Name'
      case when Customer.Title is initial
      then
      concat_with_space( Customer.FirstName, Customer.LastName, 1 )
      else
      concat_with_space(Customer.Title, concat_with_space( Customer.FirstName, Customer.LastName, 1 ), 1)
      end                                                      as CustomerName,

      Customer.Street,
      Customer.PostalCode,
      Customer.City

}
where Customer.CountryCode = 'DE'
