@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GenreText'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_GenreText as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(p_domain_name:'ZABAP_GENRE')
{
    key value_low,
    @EndUserText.label:'Genre Text'
    @EndUserText.quickInfo: 'Genre Text'
    text 
}
where language = $session.system_language
