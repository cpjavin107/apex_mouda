
import 'package:apex_mouda/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/colors/appcolors.dart';
import '../widgets/bg_image.dart';
import 'home/home_page.dart';
import 'login_pages.dart';
// ignore_for_file: prefer_const_constructors

class Select extends StatefulWidget {

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children:<Widget> [
          Center(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.0,
                    ),
                    Image.asset(
                      "assets/images/apex_circle.png",
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      child: Column(
                        children: [
                          Padding(
                            padding:  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.maroonColor),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Material(
                                    color: AppColors.maroonColor,
                                    child:   InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap:(){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage() ));

                                     //   Navigator.pushReplacement(context, MyRoutes.loginRoute);
                                        },
                                      child: AnimatedContainer(
                                        duration: Duration(seconds: 1),
                                        height: 40,
                                        alignment: Alignment.center,

                                        child: const Text(
                                           "USER LOGIN"
                                            , style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold,),
                                         ),


                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.maroonColor),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Material(
                                    color: AppColors.maroonColor,
                                    child:   InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap:(){
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home_Page() ));

                                       // Navigator.pushNamed(context, MyRoutes.seleteHome);
                                        },
                                      child: AnimatedContainer(
                                        duration: Duration(seconds: 1),
                                        height: 40,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "LOGIN AS GUEST"
                                            ,style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold,),

                                        ),


                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.maroonColor),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Material(
                                    color: AppColors.maroonColor,
                                    child:   InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap:(){
                                        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home_Page() ));
                                       Get.to(RegisterPage());
                                        // Navigator.pushNamed(context, MyRoutes.seleteHome);
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(seconds: 1),
                                        height: 40,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "REGISTER"
                                          ,style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold,),

                                        ),


                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )

        ],
      ),

    );

  }
}