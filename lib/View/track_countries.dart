import 'package:corona_app/controllers/track_countries_screen_controller.dart';
import 'package:corona_app/models/countries_data_model.dart';
import 'package:corona_app/services/app_services.dart';
import 'package:corona_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TrackCountries extends StatelessWidget {
  TrackCountries({super.key});

  final TrackCountriesController controller =
      Get.put(TrackCountriesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: GetBuilder<TrackCountriesController>(builder: (controller) {
            return Column(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.goBack();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Countries Data',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: controller.searchController,
                    onChanged: controller.onChanged,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search Country',
                      hintStyle: TextStyle(color: Colors.white38),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: controller.countriesList.length,
                //     itemBuilder: (context, index) {
                //       final data = controller.countriesList[index];
                //       if (controller.countriesList.isEmpty) {
                //         return Expanded(
                //             child: Center(
                //           child: CircularProgressIndicator(),
                //         ));
                //       } else {
                //         return Text(data.deaths.toString());
                //       }
                //     },
                //   ),
                // ),
                Expanded(
                  child: FutureBuilder(
                    future: AppServices.fetchCountiesData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            // final data = AppServices.countriesList[index];
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          child: Container(
                                            color: Colors.white,
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: Container(
                                              color: Colors.white,
                                              height: 10,
                                              width: 80,
                                            ),
                                            subtitle: Container(
                                              color: Colors.white,
                                              height: 10,
                                              width: 80,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider()
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return ListView.builder(
                          itemCount: AppServices.countriesList.length,
                          itemBuilder: (context, index) {
                            final data = AppServices.countriesList[index];
                            final String name = data.country.toString();
                            if (controller.searchController.text
                                .trim()
                                .isEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  controller.goToDetailScreen(
                                    data.country.toString(),
                                    data.cases.toString(),
                                    data.recovered.toString(),
                                    data.countryInfo!.flag.toString(),
                                    data.critical.toString(),
                                    data.deaths.toString(),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.network(data
                                                  .countryInfo!.flag
                                                  .toString()),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                data.country.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                data.cases.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                ),
                              );
                            } else if (name.toLowerCase().contains(controller
                                .searchController.text
                                .trim()
                                .toLowerCase())) {
                              return GestureDetector(
                                onTap: () {
                                  controller.goToDetailScreen(
                                    data.country.toString(),
                                    data.cases.toString(),
                                    data.recovered.toString(),
                                    data.countryInfo!.flag.toString(),
                                    data.critical.toString(),
                                    data.deaths.toString(),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.network(data
                                                  .countryInfo!.flag
                                                  .toString()),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                data.country.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                data.cases.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
