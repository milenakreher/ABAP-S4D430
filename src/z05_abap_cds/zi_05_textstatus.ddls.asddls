@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Textstatus'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_TextStatus as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name:'/DMO/STATUS' )
{
    key domain_name,
    key value_position,
    key language,
    value_low,
    text
}
where language = $session.system_language
