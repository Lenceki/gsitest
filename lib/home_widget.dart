
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsi_test_app/country_detail_widget.dart';
import 'package:gsi_test_app/model.dart';
import 'package:gsi_test_app/repo.dart';
import 'bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HomeWidget extends StatefulWidget {
  final RepoInterface repo;
  HomeWidget(this.repo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends State<HomeWidget> {

  CountriesBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    _bloc = CountriesBloc(widget.repo);
    _bloc.add(CountriesEventFetch());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: BlocProvider(
          create: (BuildContext context) => _bloc,
          child: Column(
            children: <Widget>[
              searchBarWidget(),
              Expanded(
                child: builder(),
              )
            ],
          ),
        ),
      ),
    );
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
  Widget listCell(CountryModel data) {

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CountryDetailWidget(data)));
      },
       child: Container(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[

             Text(data.name, style: Theme.of(context).textTheme.headline5,),
             Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     countryDataWidget(tittle: "Capital", value: data.capital, isFlexible: false),
                     countryDataWidget(tittle: "Region", value: data.region, isFlexible: false),
                     countryDataWidget(tittle: "Abbv", value: data.alpha3Code, isFlexible: false),
                   ],
                 ),
                 data.flag.isEmpty ? Container() :
                 SvgPicture.network(
                   data.flag,
                   width: 100,
                   placeholderBuilder: (BuildContext context) => Container(
                       padding: const EdgeInsets.all(30.0),
                       child: const CircularProgressIndicator()),
                 ),
               ],
             ),



             countryDataWidget(tittle: "Calling codes", value: data.callingCodes.reduce((value, element) => value + ', ' + element)),
             countryDataWidget(tittle: "Population,", value: data.population),
             countryDataWidget(tittle: "Currencies", value: data.currencies.length > 0 ? data.currencies.map((e) => "${e.name}(${e.symbol})").reduce((value, element) => value + ', ' + element) : "none" ),
             countryDataWidget(tittle: "Languages", value: data.languages.length > 0 ? data.languages.map((e) => "${e.name}(${e.iso6391})").reduce((value, element) => value + ', ' + element) : "none" ),
             data.latlng.length > 0 ?
             Row(
               children: <Widget>[
                 countryDataWidget(tittle: "Latitude", value: data.latlng[0], isFlexible: false ),
                 SizedBox(
                   width: 20,
                 ),
                 countryDataWidget(tittle: "Longitude", value: data.latlng[1],  isFlexible: false ),
               ],
             ) : Container(),
             countryDataWidget(tittle: "Borders", value: data.borders.length > 0 ? data.borders.reduce((value, element) => value + ', ' + element) : "none" ),
             Divider(height: 20,thickness: 2,)
           ],
         ),
       )
      );
  }

  Widget searchBarWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      child:  TextField(
        decoration: InputDecoration(
          hintText: "Search",
          suffix: Icon(Icons.search)
        ),
        onChanged: (val) {
          _bloc.add(CountriesEventSearch(val));
        },
      ),
    );
  }
  Widget builder() {
    return BlocBuilder<CountriesBloc, CountriesState>(

        builder: (context, state) {
          Widget body;
          if (state is LoadingCountriesState) {
            body = Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FailedCountriesState) {
            body = Center(
              child: Text(state.message),
            );
          } else if (state is SuccessCountriesState) {
            body = ListView.builder(
              itemCount: state.countries.length,
              itemBuilder: (context, index) {
                final itemValue = state.countries[index];
                return listCell(itemValue);
              },
            );;
          } else {
            body = Center(
              child: Text("Loading View"),
            );
          }

          return LayoutBuilder(
            builder: (context, constraint) {
              return Container(
                padding: EdgeInsets.all(10),
                height: constraint.maxHeight,
                width: constraint.maxWidth,
                child: body,
              );
            },
          );
        }
    );
  }
}