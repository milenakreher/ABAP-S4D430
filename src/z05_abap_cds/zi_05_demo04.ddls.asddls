@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 4: Domain Fixed Values'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_Demo04 as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name:'Z05_SYSTEM' )
{
    key domain_name,
    key value_position,
    key language,
    value_low,
    text
}
where language = $session.system_language
