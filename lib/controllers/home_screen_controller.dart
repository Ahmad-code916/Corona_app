import 'package:corona_app/View/track_countries.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  void goToCountriesTrackScreen() {
    Get.to(() => TrackCountries());
  }
}
