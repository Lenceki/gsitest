
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gsi_test_app/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class CountryDetailWidget extends StatefulWidget {
  CountryModel country;
  CountryDetailWidget(this.country);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CountryDetailWidgetState();
  }
}

class _CountryDetailWidgetState extends State<CountryDetailWidget> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition cameraPos;

  @override
  void initState() {
    // TODO: implement initState
    cameraPos = CameraPosition(

      target: LatLng(widget.country.latlng[0], widget.country.latlng[1]),
      zoom: 7,
    );
    super.initState();
  }

  Widget countryDataWidget({String tittle, dynamic value, bool isFlexible = true}) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("$tittle: ", style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),),
          isFlexible ? Flexible(
            child: Text("$value".isEmpty ? "none": "$value", style: Theme.of(context).textTheme.bodyText2,),
          ) : Text("$value".isEmpty ? "none": "$value", style: Theme.of(context).textTheme.bodyText2,)
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.alpha3Code),
      ),
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Container(
                height: MediaQuery.of(context).size.height * 0.60,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: cameraPos,
                  scrollGesturesEnabled: false,
                  mapToolbarEnabled: false,

                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),

              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: widget.country.name, style: Theme.of(context).textTheme.headline4),
                          TextSpan(text: ' (${widget.country.nativeName})', style: Theme.of(context).textTheme.subtitle1,),
                        ],
                      ),
                    ),
                    countryDataWidget(tittle: "Sub Region", value: widget.country.subregion),
                    countryDataWidget(tittle: "Code", value: widget.country.numericCode),
                    countryDataWidget(tittle: "Demonym", value: widget.country.demonym),
                    countryDataWidget(tittle: "Area", value: widget.country.area),
                    countryDataWidget(tittle: "Gini", value: widget.country.gini),
                    countryDataWidget(tittle: "Cioc", value: widget.country.cioc),
                    countryDataWidget(tittle: "Region Bloc", value: widget.country.regionalBlocs.length > 0 ? widget.country.regionalBlocs.map((e) => "${e.name}(${e.acronym})").toList().reduce((value, element) => value +", " + element) : "none"),
                    countryDataWidget(tittle: "Timezones", value: widget.country.timezones.length > 0 ?  widget.country.timezones.reduce((value, element) => value +", " + element) : "none"),
                    countryDataWidget(tittle: "Timezones", value: widget.country.timezones.length > 0 ?  widget.country.timezones.reduce((value, element) => value +", " + element) : "none"),
                    countryDataWidget(tittle: "Top Level Domain", value: widget.country.topLevelDomain.length > 0 ?  widget.country.topLevelDomain.reduce((value, element) => value +", " + element) : "none"),
                    countryDataWidget(tittle: "Alternate Spelling", value: widget.country.altSpellings.length > 0 ?  widget.country.altSpellings.reduce((value, element) => value +", " + element) : "none"),
                    translationWidget()
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget translationWidget() {
    if (widget.country.translations.length == 0) return Container();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Translations:", style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),),
          Column(
            children: widget.country.translations.keys.toList().map((e) => Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1)
                    ),
                    child: Text("$e"),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1)
                    ),
                    child: Text("${widget.country.translations[e]}"),
                  ),
                )
              ],
            )).toList(),
          ),
        ],
      )
    );
  }
}