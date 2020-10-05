
abstract class ModelBase {
  ModelBase.fromJson(Map<String, dynamic> json);
 Map<String, dynamic> toJson();

 Map<String, dynamic> mockData() {
   return null;
 }
}

class CountryModel extends ModelBase {
  String name;
  List<String> topLevelDomain;
  String alpha2Code;
  String alpha3Code;
  List<String> callingCodes;
  String capital;
  List<String> altSpellings;
  String region;
  String subregion;
  num population;
  List<num> latlng;
  String demonym;
  num area;
  num gini;
  List<String> timezones;
  List<String> borders;
  String nativeName;
  String numericCode;
  List<CurrenciesModel> currencies;
  List<LanguageModel> languages;
  Map<String, dynamic> translations;
  String flag;
  List<RegionalBlocsModel> regionalBlocs;
  String cioc;

  CountryModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    name = json.sString("name");
    topLevelDomain = json.sList<String>("topLevelDomain");
    alpha2Code = json.sString("alpha2Code");
    alpha3Code = json.sString("alpha3Code");
    callingCodes = json.sList<String>("callingCodes");
    capital = json.sString("capital");
    altSpellings = json.sList<String>("altSpellings");
    region = json.sString("region");
    subregion = json.sString("subregion");
    population = json.sNum("population");
    latlng = json.sList<num>("latlng");
    demonym = json.sString("demonym");
    area = json.sNum("area");
    gini = json.sNum("gini");
    timezones = json.sList<String>("timezones");
    borders = json.sList<String>("borders");
    nativeName = json.sString("nativeName");
    numericCode = json.sString("numericCode");
    currencies = json.sList("currencies").map((e) => CurrenciesModel.fromJson(e)).toList();
    languages = json.sList("languages").map((e) => LanguageModel.fromJson(e)).toList();
    translations = json.sMap("translations");
    flag = json.sString("flag");
    regionalBlocs = json.sList("regionalBlocs").map((e) => RegionalBlocsModel.fromJson(e)).toList();
    cioc = json.sString("cioc");
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return {
      "name": name,
      "topLevelDomain": topLevelDomain,
      "alpha2Code": alpha2Code,
      "alpha3Code": alpha3Code,
      "callingCodes": callingCodes,
      "capital": capital,
      "altSpellings": altSpellings,
      "region": region,
      "subregion": subregion,
      "population": population,
      "latlng": latlng,
      "demonym": demonym,
      "area": area,
      "gini": gini,
      "timezones": timezones,
      "borders": borders,
      "nativeName": nativeName,
      "numericCode": numericCode,
      "currencies": currencies.map((e) => e.toJson()).toList(),
      "languages": languages.map((e) => e.toJson()).toList(),
      "translations": translations,
      "flag": flag,
      "regionalBlocs": regionalBlocs.map((e) => e.toJson()).toList(),
      "cioc": cioc
    };
  }
  @override
  Map<String, dynamic> mockData() {
    // TODO: implement mockData
    return {
      "name": "Afghanistan",
      "topLevelDomain": [
        ".af"
      ],
      "alpha2Code": "AF",
      "alpha3Code": "AFG",
      "callingCodes": [
        "93"
      ],
      "capital": "Kabul",
      "altSpellings": [
        "AF",
        "Afġānistān"
      ],
      "region": "Asia",
      "subregion": "Southern Asia",
      "population": 27657145,
      "latlng": [
        33,
        65
      ],
      "demonym": "Afghan",
      "area": 652230,
      "gini": 27.8,
      "timezones": [
        "UTC+04:30"
      ],
      "borders": [
        "IRN",
        "PAK",
        "TKM",
        "UZB",
        "TJK",
        "CHN"
      ],
      "nativeName": "افغانستان",
      "numericCode": "004",
      "currencies": [
        {
          "code": "AFN",
          "name": "Afghan afghani",
          "symbol": "؋"
        }
      ],
      "languages": [
        {
          "iso639_1": "ps",
          "iso639_2": "pus",
          "name": "Pashto",
          "nativeName": "پښتو"
        },
        {
          "iso639_1": "uz",
          "iso639_2": "uzb",
          "name": "Uzbek",
          "nativeName": "Oʻzbek"
        },
        {
          "iso639_1": "tk",
          "iso639_2": "tuk",
          "name": "Turkmen",
          "nativeName": "Türkmen"
        }
      ],
      "translations": {
        "de": "Afghanistan",
        "es": "Afganistán",
        "fr": "Afghanistan",
        "ja": "アフガニスタン",
        "it": "Afghanistan",
        "br": "Afeganistão",
        "pt": "Afeganistão",
        "nl": "Afghanistan",
        "hr": "Afganistan",
        "fa": "افغانستان"
      },
      "flag": "https://restcountries.eu/data/afg.svg",
      "regionalBlocs": [
        {
          "acronym": "SAARC",
          "name": "South Asian Association for Regional Cooperation",
          "otherAcronyms": [],
          "otherNames": []
        }

      ],
      "cioc": "AFG"
    };
  }
}

class CurrenciesModel extends ModelBase {
  String code;
  String name;
  String symbol;

  CurrenciesModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    code = json.sString("code");
    name = json.sString("name");
    symbol = json.sString("symbol");
  }



  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return {
      "code": code,
      "name": name,
      "symbol": symbol
    };
  }

  @override
  Map<String, dynamic> mockData() {
    // TODO: implement mockData
    return {
      "code": "AFN",
      "name": "Afghan afghani",
      "symbol": "؋"
    };
  }
}

class LanguageModel extends ModelBase {
  String iso6391;
  String iso6392;
  String name;
  String nativeName;

  LanguageModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    iso6391 = json.sString("iso639_1");
    iso6392 = json.sString("iso639_2");
    name = json.sString("name");
    nativeName = json.sString("nativeName");
  }

  @override
  Map<String, dynamic > toJson() {
    // TODO: implement toJson
   return {
     "iso639_1": iso6391,
     "iso639_2": iso6392,
     "name": name,
     "nativeName": nativeName
   };
  }

  @override
  Map<String, dynamic> mockData() {
    // TODO: implement mockData
    return {
      "iso639_1": "tk",
      "iso639_2": "tuk",
      "name": "Turkmen",
      "nativeName": "Türkmen"
    };
  }
}

class RegionalBlocsModel extends ModelBase {
  String name;
  String acronym;

  RegionalBlocsModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    name = json.sString("name");
    acronym = json.sString("acronym");
  }


  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return {
      "acronym": acronym,
      "name": name,
      "otherAcronyms": [],
      "otherNames": []
    };
  }

  @override
  Map<String, dynamic> mockData() {
    // TODO: implement mockData
    return {
      "acronym": "SAARC",
      "name": "South Asian Association for Regional Cooperation",
      "otherAcronyms": [],
      "otherNames": []
    };
  }
}

extension SafetyHandle on Map<String, dynamic> {

  List<T> sList<T extends dynamic>( String key, {bool isNullable = false}) {
    if (this.containsKey(key)) {
      final value = this[key];
      return List.from(value).map((e) => e as T).toList();
    }
    return isNullable? null : [];
  }

  Map<String, dynamic> sMap(String key, {bool isNullable = false}) {
    if (this.containsKey(key)) {
      final value = this[key];
      return Map<String,dynamic>.from(value);
    }
    return isNullable? null : Map<String, dynamic>();
  }

  String sString(String key, {bool isNullable = false}) {
    if (this.containsKey(key)) {
      return "${this[key]}";
    }
    return isNullable? null : "";
  }

  num sNum(String key, {bool isNullable = false}) {
    final defaultValue = isNullable ? null : 0;
    if (this.containsKey(key)) {
      try {
        final value = this[key];
        if (value is String) {
          return num.tryParse(this[key]) ?? defaultValue;
        }
        return value;
      } catch (e) {
        return defaultValue;
      }
    }
    return defaultValue;
  }
}