import 'package:corona_app/View/detailed_screen.dart';
import 'package:corona_app/models/countries_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TrackCountriesController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final CountriesDataModel countriesDataModel = CountriesDataModel();
  // List<CountriesDataModel> countriesList = [];
  // List<CountriesDataModel> allCountries = [];

  void goBack() {
    Get.back();
  }

/*  @override
  void onInit() {
    AppServices.fetchCountiesData();
    super.onInit();
  }

  void fetchCountriesList() async {
    var fetchedList = await AppServices.fetchCountiesData();
    countriesList.assignAll(fetchedList);
    allCountries = fetchedList;
  }*/

  void onChanged(String val) {
   /* if (searchController.text.isEmpty) {
      countriesList.assignAll(allCountries);
    } else {
      countriesList.assignAll(countriesList.where(
        (country) => country.country!.toLowerCase().contains(val.toLowerCase()),
      ));
    }*/
    searchController.text = val;
    update();
  }

  void goToDetailScreen(String name, String cases, String recovered,
      String flag, String deaths, String critical) {
    Get.to(() => DetailedScreen(
          recovered: recovered,
          name: name,
          cases: cases,
          flag: flag,
          critical: critical,
          deaths: deaths,
        ));
  }
}
