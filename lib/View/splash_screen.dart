import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        Get.offAll(() => const HomeScreen());
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      color: Colors.blueGrey,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: controller,
            child: SvgPicture.asset('assets/images/covid-19-icon.svg',
                color: Colors.white),
            builder: (context, child) {
              return Transform.rotate(
                angle: controller.value * 2.0 * math.pi,
                child: child,
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            textAlign: TextAlign.center,
            'Covid-19\nTracker App',
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),
          )
        ],
      ),
    )));
  }
}
