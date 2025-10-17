@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Textelement for Runtime in Minutes'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_RuntimeText as select from ZR_05_Movie
{
    key RuntimeInMin,
    case when RuntimeInMin > 150 then ' Hinweis: Überlänge'
        when RuntimeInMin between 0 and 30 then 'Hinweis: Kurzfilm'
        else '' end as RuntimeText 
}
