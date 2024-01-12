import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apex_mouda/res/routes/my_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/filtercharts_controller.dart';
import '../models/adsfirst.dart';
import 'package:get/get.dart';

// ignore_for_file: prefer_const_constructors

class Ads_Image extends StatefulWidget{
  @override
  State<Ads_Image> createState() => _Ads_ImageState();
}

class _Ads_ImageState extends State<Ads_Image> {
  var res,ads;
  bool statu = false;
  String check ="1";
  AdsController adsController = Get.put(AdsController());
  List<Ads> adsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    // getAds();
    Timer(Duration(seconds: 5), () => Navigator.of(context).pushReplacementNamed(
        statu == null?MyRoutes.selectLoginOrGuest: MyRoutes.seleteHome));
  }

  fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    statu = preferences.getBool("status")!;
    print("login:" + statu.toString());
  }
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Obx( () => Column(
                  children: [
                    SizedBox(height: 100.0,),
                    adsController.adsList.value.isEmpty?  Center(child: CircularProgressIndicator()):
                    Center(child: Image.network(adsController.adsList.value[0].bigImage??"", fit: BoxFit.contain,))
                  ],
                ),
              )
          ),
        )
    );
  }
  // Future<dynamic> getAds() async {
  //   adsData = await adsController.fetchProducts() ;
  //   return adsData;
  // }
}
