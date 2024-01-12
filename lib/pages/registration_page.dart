import 'package:apex_mouda/pages/home/home_page.dart';
import 'package:apex_mouda/pages/login_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/registration_controller.dart';
import '../res/colors/appcolors.dart';
import '../widgets/bg_image.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _mobileController=TextEditingController();
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  late  ScaffoldMessengerState scaffoldMessenger ;
  RegisterController registerController=Get.put(RegisterController());
  late FocusNode _nameFocusNode;
  late FocusNode _phoneFocusNode;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
  }
  @override
  void dispose() {
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children:<Widget> [
           // BgImage(),
          SingleChildScrollView(
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
                    height: 20.0,
                  ),
                  const Text("NEW USER REGISTRATION FORM"
                      ,style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold,)
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
                          focusNode: _nameFocusNode,
                          controller: _nameController,
                          style: TextStyle(color: Colors.black),
                          onSaved: (val) {

                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter Name",
                            labelText: "Name",
                            hintStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                            labelStyle: TextStyle(
                                color:  Colors.black
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
                              return "Name cannot be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0,),
                        TextFormField(
                          focusNode: _phoneFocusNode,
                          maxLength: 10,
                          controller: _mobileController,
                          style: TextStyle(color: Colors.black),
                          onChanged: (value){
                            if(value.length==10){
                              FocusScope.of(context).unfocus();
                            }
                          },
                          onSaved: (val) {

                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Enter Mobile no.",
                            labelText: "Mobile Number",
                            hintStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                            labelStyle: TextStyle(
                                color:  Colors.black
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
                        SizedBox(height: 10.0,),
                        TextFormField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.black),
                          onSaved: (val) {

                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Enter Email Id",
                            labelText: "Email Id",
                            hintStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                            labelStyle: TextStyle(
                                color:  Colors.black
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.black)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.black)),

                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0,),
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
                                if(_nameController.text.isEmpty) {
                                  _nameFocusNode.requestFocus();
                                  // scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter Name")));
                                }else if(_mobileController.text.isEmpty) {
                                  _phoneFocusNode.requestFocus();
                                  // scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter mobile no.")));
                                }
                                else if(_mobileController.text.length!=10) {
                                  _phoneFocusNode.requestFocus();
                                  scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Enter valid mobile no.")));
                                }else if(_emailController.text.isNotEmpty){
                                 if(!isValidEmail(_emailController.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Valid Email Id", style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
                                }else{
                                   registerController.registration(_nameController.text,_emailController.text??"",_mobileController.text,context);
                                 }
                                }
                                else{

                                  registerController.registration(_nameController.text,_emailController.text??"",_mobileController.text,context);
                                  // showDialog(
                                  //   barrierDismissible: false,
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return AnimatedDialog(
                                  //       title: 'Thank you for registering with Apex Mouda!',
                                  //       description: "Your account details have been received. \n\nTry to login after some days.",
                                  //     );
                                  //   },
                                  // );
                                }

                              },
                              child:SizedBox(child: const Text("REGISTER"
                                  ,style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold,)
                              )) ),
                        ),
                      ],
                    ),
                  )
                ],
              ),


            ),
          )
        ],
      ),

    );
  }
  bool isValidEmail(String email) {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }
}
class AnimatedDialog extends StatelessWidget {
  final String title;
  final String description;

  AnimatedDialog({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  textAlign:TextAlign.center,
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              Divider(thickness: 3,),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  textAlign:TextAlign.start,
                  description,
                  style: TextStyle(fontSize: 14),
                ),
              ),

              SizedBox(height: 15),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Set the background color here
                  ),
                  onPressed: () {
                    Get.off(Home_Page()); // Close the dialog
                  },
                  child: Text('OKay'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
