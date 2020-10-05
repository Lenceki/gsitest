
import 'model.dart';
import 'package:dio/dio.dart';
abstract class RepoInterface {
  Future<List<CountryModel>> fetchCountries();
}

class Repo implements RepoInterface{
  Dio _dio = new Dio();
  @override
  Future<List<CountryModel>> fetchCountries() async {
    // TODO: implement fetchCountries
    try {
      final res = await _dio.get("https://restcountries.eu/rest/v2");
      return List.from(res.data).map((e) => CountryModel.fromJson(e)).toList();
    } catch(e) {
      throw("There seems to be a problem! Please try again later.");
    }
  }

}