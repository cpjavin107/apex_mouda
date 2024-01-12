import 'package:flutter/material.dart';

import '../../res/colors/appcolors.dart';
// ignore_for_file: prefer_const_constructors

class About_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        elevation: 0.0,
        backgroundColor: AppColors.maroonColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
     body: Stack(
       fit: StackFit.expand,
         children:<Widget> [
          Center(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Welcome to Apex Mouda",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "At Apex Mouda App, we're passionate about creating innovative solutions that make a difference in people's lives. Founded in [Year], we set out on a mission to [brief description of your app's main purpose or service]. Our team is dedicated to delivering a seamless and enjoyable experience for our users.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],

            ),


          )


      ]
     ),
    );

  }

}