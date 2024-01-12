import 'package:apex_mouda/pages/login_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/sp_constants.dart';
import '../../../helper/screen_anim.dart';
import '../../../helper/shared_pref.dart';
import '../../../res/colors/appcolors.dart';
import '../../../res/routes/my_routes.dart';
import '../../member/members.dart';
import '../../suggestion_complain_screen.dart';

class Body extends StatefulWidget {
   Body({super.key});
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String member_id="";
  @override
  void initState() {
    super.initState();
    var map = SharedPref.getPref();
    member_id = map[SpConstants.MEMBER_ID]??"";
  }
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        InkWell(
          child: _Card(Icons.person_outline, "Members"),
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.members);
          },
        ),
        InkWell(
          child: _Card(Icons.supervisor_account, " Executive\nCommittee"),
          /* Container(
            decoration: BoxDecoration(
              color: AppColors.maroonColor,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.supervisor_account,size: 40, color:Colors.white),
                        Center(child: Text("EXECUTIVE \nCOMMITTEE", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),)),
                      ]
                  ),
                ),
              ],
            ),
          ),*/
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.committee);
          },
        ),



        InkWell(
          child: _Card(Icons.search, "Alphabetical\n     Search"),
          /*Container(
            decoration: BoxDecoration(
              color: AppColors.maroonColor,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.search,size: 40, color:Colors.white),
                        Center(child: Text("ALPHABETICAL \nSEARCH", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),)),
                      ]
                  ),
                ),
              ],
            ),
          ),*/
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.alphasearch);
          },
        ),
        InkWell(child: _Card(Icons.message, "Suggestion\n Complaint"),
          /*Container(
            decoration: BoxDecoration(
              color: AppColors.maroonColor,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.search,size: 40, color:Colors.white),
                        Center(child: Text("ALPHABETICAL \nSEARCH", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),)),
                      ]
                  ),
                ),
              ],
            ),
          ),*/
          onTap: () {
            member_id==""?Get.off(LoginPage()):Get.to(SuggestionComplainScreen());
          },
        ),
        InkWell(
          child: _Card(Icons.info, "Useful\nDetails"),
          /*  Container(
            decoration: BoxDecoration(
              color: AppColors.maroonColor,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.info, size: 40, color: Colors.white),
                        Text(
                          "USEFUL \nDETAILS",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ],
            ),
          ),*/
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.selectUseful);
          },
        ),
        InkWell(
          child: _Card(Icons.library_books, " News"),
          /* Container(
            decoration: BoxDecoration(
              color: AppColors.maroonColor,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.library_books,size: 40, color:Colors.white),
                        Center(child: Text("NEWS & EVENTS", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),)),
                      ]
                  ),
                ),
              ],
            ),
          ),*/
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.news);
          },
        ),
        InkWell(
          child: _Card(Icons.library_books, "Events"),
          /* Container(
            decoration: BoxDecoration(
              color: AppColors.maroonColor,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.library_books,size: 40, color:Colors.white),
                        Center(child: Text("NEWS & EVENTS", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),)),
                      ]
                  ),
                ),
              ],
            ),
          ),*/
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.event);
          },
        ),
        InkWell(
          child: _Card(Icons.info, " Holiday\nCalender"),
          /* Container(
            decoration: BoxDecoration(
              color: AppColors.maroonColor,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.business, size: 40, color: Colors.white),
                        Text(
                          "HOLIDAY \nCALENDER",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ],
            ),
          ),*/
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.viewholiday);
          },
        ),
        InkWell(
          child: _Card(Icons.question_answer, "Enquiry"),
          /*Container(
            decoration: BoxDecoration(
              color: AppColors.maroonColor,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.question_answer,
                            size: 40, color: Colors.white),
                        Text(
                          "ENQUIRY",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ],
            ),
          ),*/
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.seleteenquiry);
          },
        ),
      ],
    );
  }

  Widget _Card(IconData icon, var title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shadowColor: AppColors.maroonColor,
        elevation: 5.0, // Set the elevation for the shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Set the corner radius
        ),
        child: Container(
          width: 150.0,
          height: 150.0,
           decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.maroonColor.withOpacity(0.1),AppColors.maroonColor.withOpacity(0.2),AppColors.maroonColor.withOpacity(0.3)], // Define your gradient colors
            ),
            borderRadius: BorderRadius.circular(12.0), // Set the corner radius
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(26.0), // Set the corner radius
                ),
                elevation: 10,
                child: Container(
                  height: 56,
                  width: 56,
                  child: Icon(
                    icon,
                    size: 30.0,
                    color: AppColors.maroonColor,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.maroonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

