@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo 3: Functions and Operatiors'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_05_Demo03
  as select from /dmo/connection
{
  /* Literatle und mathematische Ooperatoren */
  'Hello World'                                                               as Text1,
  42                                                                          as Int1,
  '4.4'                                                                       as Decimal1,
  5.5                                                                         as Fltp1,
  5 + 3                                                                       as Add1,
  5 - 3                                                                       as Sub1,
  5 * 3                                                                       as Mult1,
  5 / 3                                                                       as Div1,

  /* Typumwandlungen */
  ' LH'                                                                       as CarrierID1,
  cast(' LH' as /dmo/carrier_id)                                              as CarrierId2,

  /* Mathematische Funktionen */
  div(5, 3)                                                                   as Div2,
  mod(5, 3)                                                                   as Mod1,
  division(5, 3, 8)                                                           as Div3,
  round(distance, -3)                                                         as Round1,

  /* Zeichenkettenfunktionen */

  upper('Hello World')                                                        as Upper1,

  /* Währungs- und Einheitenumrechnungen*/
  distance                                                                    as OldDistance,
  @Semantics.quantity.unitOfMeasure: 'NewDistanceUnit'
  cast(unit_conversion(
    quantity => distance,
    source_unit => distance_unit,
    target_unit => $projection.NewDistanceUnit )        as abap.quan(16, 2) ) as NewDistance,
  cast('MI' as abap.unit)                                                     as NewDistanceUnit,

  /* Datums- und Zeit- und Zeitstempelfunktionen */
  dats_add_days($session.system_date, 40, 'FAIL')                             as Dats1,

  /* Cases */
  case when distance >= 5000 then 'Langstreckenflug'
        when distance between 1000 and 5000 then 'Mittelstreckenflug'
        else 'Kurzstreckenflug'
        end                                                                   as FlightType,
  case distance_unit when 'KM' then 'Kilometer'
                     when 'MI' then 'Meilen'
                     else '' end                                              as DistanceUnit


}
