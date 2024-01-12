import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/shared_pref.dart';
import '../res/colors/appcolors.dart';
import 'otp_page.dart';
// ignore_for_file: prefer_const_constructors


class LoginPage extends StatefulWidget  {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  FocusNode myFocusNode = FocusNode();
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();
   String? mobile, password;
  bool isLoading=false;
  final TextEditingController _mobileController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late  ScaffoldMessengerState scaffoldMessenger ;


  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        changeButton = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children:<Widget> [
        //  BgImage(),
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
                      "Apex Mouda",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Making a Difference",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
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
                            maxLength: 10,
                            controller: _mobileController,
                            onChanged: (value){
                              if(value.length==10){
                                FocusScope.of(context).unfocus();
                              }
                            },
                            style: TextStyle(color: Colors.black),
                            onSaved: (val) {
                              mobile = val;
                            },
                            keyboardType: TextInputType.number,
                            focusNode: myFocusNode,
                            decoration: InputDecoration(
                              hintText: "Enter Mobile no.",
                              labelText: "Mobile Number",
                              hintStyle: TextStyle(fontSize: 14.0, color: Colors.orange),
                             labelStyle: TextStyle(
                              color: myFocusNode.hasFocus ? Colors.blue : Colors.black
                          ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),

                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Mobile Number cannot be empty";
                              } else if (value!.length < 10) {
                                return "Mobile Number length should be atleast 10 digit";
                              }
                              return null;
                            },
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
                                onPressed: (){
                                  if(isLoading) {return;}
                                  if(_mobileController.text.isEmpty) {
                                    scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter valid mobile no.")));
                                    return;
                                  }
                                  login(_mobileController.text,_passwordController.text);
                                  setState(() {
                                    isLoading=true;
                                  });

                                },
                                child:SizedBox(child: const Text("SUBMIT"
                                    ,style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold,)
                                )) ),
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

 void  login(String mob, String pass) async {
     Map data = {
       'mobile': mob,
       'password': pass,
       'deviceToken': '',
       'deviceId': ''
     };
     print(data.toString());
     isLoading= true;
     final  response= await http.post(
       Uri.parse("http://japps.co.in/apexmouda/nismwa_api/index.php/Member/memberLogin"),
       body: data,);
    // print(response);
     setState(() {
       isLoading=false;
     });

     if (response.statusCode == 200) {
         var resposne1 = jsonDecode(response.body);
         print(resposne1);
         print(resposne1['status']);
         if(resposne1['status']==0){
           scaffoldMessenger.showSnackBar(SnackBar(content:Text("Invalid Mobile Number")));
         }else{
           var user = resposne1['data'];
           // SharedPref.savePref(user[0]["id"],user[0]["name_of_the_member"],user[0]["email_id"],user[0]["contact_number"],
           //     user[0]["firm_name"],user[0]["image"],user[0]["executive_patron_life_member"]);

           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OTP_Page(value :user[0]["contact_number"], mobile: '$mob',) ));

  
         }
         //{status: 0, msg: Invalid Username/Password}

     } else {
       scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please try again!")));
     }


   }

  
}