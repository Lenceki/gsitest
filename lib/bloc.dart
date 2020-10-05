import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gsi_test_app/model.dart';
import 'package:gsi_test_app/repo.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  RepoInterface repo;
  List<CountryModel> filteredList;
  List<CountryModel> orginalList;
  CountriesBloc(this.repo) : super(NoneCountriesState());

  @override
  Stream<CountriesState> mapEventToState(CountriesEvent event) async* {
    // TODO: implement mapEventToState
    yield LoadingCountriesState();
    if (event is CountriesEventFetch) {
      try {
        final res = await repo.fetchCountries();
        orginalList = res;
        yield SuccessCountriesState(res);
      } catch(err) {
        yield FailedCountriesState(err);
      }
    } else if (event is CountriesEventSearch && orginalList != null) {

      if (event.name.length < 1) {
        yield SuccessCountriesState(orginalList);
        return;
      }
      final res = orginalList.where((element) => element.name.toLowerCase().indexOf(event.name.toLowerCase()) >= 0 || element.alpha3Code.toLowerCase().indexOf(event.name.toLowerCase()) >= 0).toList();
      if (res != null && res.length > 0) {
        yield SuccessCountriesState(res);
      } else {
        yield FailedCountriesState("No Search Found");
      }

    }
  }

}
//Event
@immutable
abstract class CountriesEvent extends Equatable {
  CountriesEvent([List props = const []]) : super(props);
}

class CountriesEventFetch extends CountriesEvent {}

class CountriesEventSearch extends CountriesEvent {
  final String name;
  CountriesEventSearch(this.name);
}

//State
@immutable
abstract class CountriesState extends Equatable {
  CountriesState([List props = const []]) : super(props);
}

class SuccessCountriesState extends CountriesState {
  final List<CountryModel> countries;
  SuccessCountriesState(this.countries);
}

class NoneCountriesState extends CountriesState {}
class LoadingCountriesState extends CountriesState {}
class FailedCountriesState extends CountriesState {
  final String message;
  FailedCountriesState(this.message);
}

