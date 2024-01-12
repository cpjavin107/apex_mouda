import 'package:apex_mouda/constants/sp_constants.dart';
import 'package:apex_mouda/helper/shared_pref.dart';
import 'package:apex_mouda/res/routes/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../res/colors/appcolors.dart';
import '../../alphabetical_search/list_user_details.dart';
import '../../drawer_all_pages/about_us.dart';
import '../../drawer_all_pages/help.dart';
import '../../select_page.dart';
import '../home_page.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  var res, ads,mobile;
  String member_id="",name="",image="",email="";
  bool userLogin = false;

  @override
  void initState(){
    super.initState();
    var map = SharedPref.getPref();
    mobile = map[SpConstants.MOBILE_NUMBER]??"";
    member_id = map[SpConstants.MEMBER_ID]??"";
    name = map[SpConstants.NAME]??"";
    image = map[SpConstants.IMAGE]??"";
    email = map[SpConstants.EMAIL]??"";

    print("$userLogin\n $mobile\n$member_id\n$name\n$image\n$email");
  }



  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>  [
          DrawerHeader(
            padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
            decoration: BoxDecoration(color: AppColors.maroonColor,),

            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: AppColors.maroonColor,),

              currentAccountPicture: Container(
                child: member_id == "" ?
                CircleAvatar(backgroundImage:AssetImage("assets/images/profile_icon.png"),):
                CircleAvatar(backgroundImage: NetworkImage(image),),
                padding: EdgeInsets.all(0),
              ),


              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

              accountName: member_id == "" ?
              Text("Register/Login", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),):
              Text(name, style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold,),),


              accountEmail: Visibility(visible:member_id == "" ? false:true,
                  child: Text(email, style: TextStyle(fontSize: 12, color: Colors.white,)),),
            ),
          ),
          Container(
            child: member_id == "" ?
            ListTile(
              title: Text("Home",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.maybePop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Select()));

              },
              trailing: Icon(Icons.keyboard_arrow_right,size: 30, color:Colors.black),
            ): ListTile(
              title: Text("Home",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,

                ),
              ),
              onTap: () {

                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home_Page() ));
              },
              trailing: Icon(Icons.keyboard_arrow_right,size: 30, color:Colors.black),
            ),
          ),
          Container(
              child: member_id == "" ? Visibility(
                visible: false,
                child:  Divider(color: Colors.black),
              ):Divider(color: Colors.black)
          ),
          Container(
              child:Visibility(
                visible: member_id == "" ?false : true,
                child: ListTile(
                  title: Text("Profile",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Alpha_detail_Page(value : member_id,) ));

                    // Navigator.of(context).pushNamed(MyRoutes.profile);
                  },
                  trailing: Icon(Icons.keyboard_arrow_right,size: 30, color:Colors.black),
                ),
              )
          ),
          Divider(color: Colors.black),
          ListTile(
            title: Text("Help & Support",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Help_Page()));
            },
            trailing: Icon(Icons.keyboard_arrow_right,size: 30, color:Colors.black),
          ),
          Divider(color: Colors.black),
          ListTile(
            title: Text("Invite",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: (){
              share(context);
            },
            trailing: Icon(Icons.keyboard_arrow_right,size: 30, color:Colors.black),
          ),
          Divider(color: Colors.black),
          ListTile(
            title: Text("About App",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => About_Page()));
            },
            trailing: Icon(Icons.keyboard_arrow_right,size: 30, color:Colors.black),
          ),
          Divider(color: Colors.black),
          Container(
              child:
              Visibility(
                visible: member_id == "" ? false :true,
                child: ListTile(
                  title: Text("Logout",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    SharedPref.userLogout();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => Select()));
                  },
                  trailing: Icon(Icons.keyboard_arrow_right,size: 30, color:Colors.black),
                ),
              )
          ),
        ],
      ),
    );
  }

  share(BuildContext context)  async {

    // FlutterShare.share(
    //     title: 'Example share',
    //     text: 'Example share text',
    //     linkUrl: 'https://flutter.dev/',
    //     chooserTitle: 'Example Chooser Title'
    // );
  }




}
