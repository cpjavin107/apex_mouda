import 'dart:async';
import 'dart:ui';

import 'package:apex_mouda/helper/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:apex_mouda/res/colors/appcolors.dart';
import 'package:apex_mouda/res/routes/my_routes.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

import '../controllers/filtercharts_controller.dart';
import '../helper/screen_anim.dart';
import '../widgets/bg_image.dart';
import '../widgets/splase_ads.dart';
// ignore_for_file: prefer_const_constructors

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  AdsController adsController = Get.put(AdsController());
  @override
  void initState() {
    super.initState();
    getAds();
    SharedPref.getInstance();
     Timer(const Duration(seconds: 5),
            // () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            // builder: (BuildContext context) => Ads_Image())));
        () => Navigator.of(context).pushReplacement(ScreenAnim.createRoute(Ads_Image())));
  }

  Route createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Ads_Image(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<dynamic> getAds() async {
    return await adsController.fetchProducts() ;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          fit: StackFit.expand,
          children:<Widget> [
            Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                  child: SizedBox(),
                )
            ),
            RiveAnimation.asset("assets/rive_animations/new_file.riv",),

             BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: SizedBox(),
            ),

            Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100.0,
                  ),
                  Image.asset(
                    "assets/images/apex_circle.png",
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Lottie.asset("assets/images/lottie_loading.json"),
                  // Text(
                  //   "Loading App...",
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            )
        ),



          ]
      ),
    );
  }

}