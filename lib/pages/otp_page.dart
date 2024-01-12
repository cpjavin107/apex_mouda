import 'dart:convert';

import 'package:apex_mouda/helper/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../res/colors/appcolors.dart';
import 'home/home_page.dart';
// ignore_for_file: prefer_const_constructors

class OTP_Page extends StatefulWidget{
  String? value;
  String mobile;
  OTP_Page({Key? key,  this.value,required this.mobile}) : super(key : key );

  @override
  State<OTP_Page> createState() => _OTP_PageState(value!);
}

class _OTP_PageState extends State<OTP_Page> {
  FocusNode myFocusNode = FocusNode();
  String? value;
  _OTP_PageState(this.value);
   late SharedPreferences prefs;

  final _formKey = GlobalKey<FormState>();
  String? otp,mobile;
  bool isLoading=false;
  final TextEditingController _otpController=TextEditingController();
  final GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger ;

  @override
  void initState() {
    super.initState();
    fetch();
  }
  fetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile = prefs.getString('mobileNumber') ?? '';
  }
  bool changeButton = false;
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
     title: Text("OTP"),
     elevation: 0.0,
     backgroundColor: AppColors.maroonColor,
     iconTheme: IconThemeData(color: Colors.white),
   ),
   body: Stack(
     fit: StackFit.expand,
     children:<Widget> [
      // BgImage(),
       Center(
         child: SingleChildScrollView(
           child: Form(
             key: _formKey,

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
                   height: 10.0,
                 ),
                 Text(
                   "Enter your OTP here!",
                   style: TextStyle(
                     fontSize: 15,
                     color: Colors.black,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 SizedBox(
                   height: 20.0,
                 ),
                 Padding(
                   padding:
                   const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                   child: Column(
                     children: [
                       TextFormField(
                         controller: _otpController,
                         style: TextStyle(color: Colors.black),
                         onSaved: (val) {
                           otp = val;
                         },
                         onChanged: (val) {
                           if(val.length==6){
                             FocusScope.of(context).unfocus();
                             OTP(_otpController.text,);
                             setState(() {
                               isLoading=true;
                             });
                           }
                         },
                         keyboardType: TextInputType.number,
                         focusNode: myFocusNode,

                         decoration: InputDecoration(
                           hintText: "Enter OTP",
                           labelText: "OTP",
                           hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                           labelStyle: TextStyle(
                               color: myFocusNode.hasFocus ? Colors.blue : Colors.black
                           ),
                           border:OutlineInputBorder(
                               borderRadius: BorderRadius.all(Radius.circular(5.0)),
                               borderSide: BorderSide(color: Colors.black)) ,
                           focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.all(Radius.circular(5.0)),
                               borderSide: BorderSide(color: Colors.black)),

                         ),

                       ),
                       SizedBox(
                         height: 20,
                       ),
                       SizedBox(
                         width: MediaQuery.of(context).size.width,
                         child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               primary: AppColors.maroonColor,
                               onPrimary: Colors.white,
                               shadowColor: AppColors.maroonColor,
                               elevation: 8,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10.0)),
                               minimumSize: Size(100, 40), //////// HERE
                             ),
                             onPressed: ()  {
                               if(isLoading)
                               {
                                 return;
                               }
                               if(_otpController.text.isEmpty)
                               {
                                 scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter valid mobile no.")));
                                 return;
                               }
                               OTP(_otpController.text,);
                               setState(() {
                                 isLoading=true;
                               });

                             },
                             child:SizedBox(child: const Text("Submit"
                                 ,style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold,)
                             )) ),
                       ),
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
  void  OTP(String otp) async {
    Map data = {
      'mobile': widget.mobile,
      'password': otp,
      'deviceToken': '',
      'deviceId': ''
    };
    print(data.toString());
    final  response= await http.post(
      Uri.parse("http://japps.co.in/apexmouda/nismwa_api/index.php/Member/memberLogin"),
      body: data,);
    print(response);
    setState(() {
      isLoading=false;
    });

    if (response.statusCode == 200) {
      var resposne1 = jsonDecode(response.body);
      print("*******************\n\n $resposne1 \n\n********************");
      if(response.body.isNotEmpty){
        if(resposne1['status']==1){
          var user = resposne1['data'];
          SharedPref.savePref(user[0]["id"],user[0]["name"],user[0]["email"],user[0]["contact_number"],
              user[0]["firm_name"],user[0]["image"],user[0]["executive_patron_life_member"]);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home_Page()));
              scaffoldMessenger.showSnackBar(SnackBar(content:Text("${resposne1['msg']}",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
        }else{
          scaffoldMessenger.showSnackBar(SnackBar(content:Text("Invalid OTP!",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
        }
      }
    } else {
      scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please try again!")));
    }


  }


}