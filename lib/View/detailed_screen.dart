import 'package:corona_app/View/home_screen.dart';
import 'package:corona_app/controllers/detailed_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailedScreen extends StatelessWidget {
  DetailedScreen({
    super.key,
    required this.name,
    required this.cases,
    required this.recovered,
    required this.flag,
    required this.deaths,
    required this.critical,
  });

  final String name;
  final String cases;
  final String recovered;
  final String flag;
  final String deaths;
  final String critical;
  final DetailedScreenController controller =
      Get.put(DetailedScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: Get.width,
        color: Colors.blueGrey,
        child: Column(
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
                    'Details',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            const SizedBox(height: 60),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Card(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        RowUsed(text: 'Country', value: name),
                        RowUsed(text: 'Cases', value: cases),
                        RowUsed(text: 'Recovered', value: recovered),
                        RowUsed(text: 'Deaths', value: deaths),
                        RowUsed(text: 'Critical', value: critical),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 50,
                  backgroundImage: NetworkImage(flag),
                ),
              ],
            ),

            /* Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              cases,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              recovered,
              style: const TextStyle(color: Colors.white),
            ),*/
          ],
        ),
      ),
    ));
  }
}
