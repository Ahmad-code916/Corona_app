import 'dart:convert';

import 'package:corona_app/models/countries_data_model.dart';
import 'package:corona_app/models/world_states_model.dart';
import 'package:corona_app/utilities/app_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:adaptive_dialog/adaptive_dialog.dart';

class AppServices {
  static Future<WorldStatesModel> fetchWorldStates() async {
    final response = await http.get(Uri.parse(AppUrls.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Status Code Error');
    }
  }

  static final List<CountriesDataModel> countriesList = [];

  static Future<List<CountriesDataModel>> fetchCountiesData() async {
    countriesList.clear();
    try {
      final response = await http.get(Uri.parse(AppUrls.countriesListApi));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (Map i in data) {
          // CountriesDataModel model = CountriesDataModel(country: i['country'],cases: i['cases']);
          countriesList.add(CountriesDataModel.fromJson(i));
        }
        return countriesList;
      } else {
        throw Exception('Status Code Error');
      }
    } catch (e) {
      showOkAlertDialog(
          context: Get.context!, title: 'Error', message: e.toString());
    }
    throw Exception('Status Code Error');
  }
}
