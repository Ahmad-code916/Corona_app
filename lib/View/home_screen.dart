import 'package:corona_app/View/track_countries.dart';
import 'package:corona_app/controllers/home_screen_controller.dart';
import 'package:corona_app/models/world_states_model.dart';
import 'package:corona_app/services/app_services.dart';
import 'package:corona_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<Color> colorList = [
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.red
  ];

  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.blueGrey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    FutureBuilder(
                      future: AppServices.fetchWorldStates(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return
                              /* Expanded(
                              child: SpinKitFadingCircle(
                                controller: controller,
                                color: Colors.white,
                              ));*/
                              const Expanded(
                                  child: Center(
                                      child: CircularProgressIndicator(
                            color: Colors.white,
                          )));
                        } else {
                          return Column(
                            children: [
                              const SizedBox(height: 20),
                              PieChart(
                                chartRadius: Get.width * .3 * 1.3,
                                dataMap: {
                                  'Total': double.parse(
                                      snapshot.data!.cases.toString()),
                                  'Recovered': double.parse(
                                      snapshot.data!.recovered.toString()),
                                  'Deaths': double.parse(
                                      snapshot.data!.deaths.toString()),
                                },
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true),
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left,
                                    legendTextStyle:
                                        TextStyle(color: Colors.white)),
                                animationDuration:
                                    const Duration(milliseconds: 1200),
                                chartType: ChartType.ring,
                                colorList: colorList,
                              ),
                              const SizedBox(height: 40),
                              Card(
                                color: Colors.grey,
                                child: Column(
                                  children: [
                                    RowUsed(
                                        text: 'Total cases',
                                        value: snapshot.data!.cases.toString()),
                                    const Divider(),
                                    RowUsed(
                                        text: 'Recovered',
                                        value: snapshot.data!.recovered
                                            .toString()),
                                    const Divider(),
                                    RowUsed(
                                        text: 'Deaths',
                                        value:
                                            snapshot.data!.deaths.toString()),
                                    const Divider(),
                                    RowUsed(
                                        text: 'Active',
                                        value:
                                            snapshot.data!.active.toString()),
                                    const Divider(),
                                    RowUsed(
                                        text: 'Critical',
                                        value:
                                            snapshot.data!.critical.toString()),
                                    const Divider(),
                                    RowUsed(
                                        text: 'Affected countries',
                                        value: snapshot.data!.affectedCountries
                                            .toString()),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              ButtonWidget(
                text: 'Track Countries',
                onTap: () {
                  Get.to(() => TrackCountries());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowUsed extends StatelessWidget {
  const RowUsed({super.key, required this.text, required this.value});

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}
