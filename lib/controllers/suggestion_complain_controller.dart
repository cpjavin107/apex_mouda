import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SuggestionComplainController extends GetxController{

  addSuggestion(title,userid,description,BuildContext context) async {
    var url ='http://japps.co.in/apexmouda/nismwa_api/index.php/Member/addComplaint';

    var map = new Map<String, dynamic>();
    map['title'] = "$title";
    map['userid'] = "$userid";
    map['description'] = "$description";

    print("*******************\n\n$map\n\n*******************");
    var response = await http.post(Uri.parse(url),
        body: map
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print("******************\n\n$jsonString\n\n************************");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your Suggestion/Complain Added Successfully')));
      Get.back();
    } else {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Try Again After Sometime')));
      Get.back();
    }
  }
}