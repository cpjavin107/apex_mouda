import 'dart:convert';

import 'package:apex_mouda/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../pages/registration_page.dart';
class RegisterController extends GetxController{

  registration(name,email,phone,BuildContext context) async {
    var url ='http://japps.co.in/apexmouda/nismwa_api/index.php/Member/registerNewUser';

    var map = new Map<String, dynamic>();
    map['name'] = "$name";
    map['email'] = "$email";
    map['phone'] = "$phone";

    print("*******************\n\n$map\n\n*******************");
    var response = await http.post(Uri.parse(url),
        body: map
    );
    var res=json.decode(response.body);
    print("************\n\n $res\n\n\n*****************");
    if (response.statusCode == 200 && res["status"]==1) {
      var jsonString = response.body;
      print("******************\n\n$jsonString\n\n************************");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${res["msg"]}',style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
      // Get.off(Home_Page());
      // Get.back();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AnimatedDialog(
            title: 'Thank you for registering with Apex Mouda!',
            description: "Register successfully, Please wait for approval!",
          );
        },
      );
    } else {
      print(res);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text('${res["msg"]}',style: TextStyle(color: Colors.white),),backgroundColor: Colors.red));
    }
  }

}