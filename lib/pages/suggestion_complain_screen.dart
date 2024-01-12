import 'package:apex_mouda/widgets/bg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/sp_constants.dart';
import '../controllers/suggestion_complain_controller.dart';
import '../helper/shared_pref.dart';
import '../res/colors/appcolors.dart';

class SuggestionComplainScreen extends StatefulWidget {

   SuggestionComplainScreen({super.key});

  @override
  State<SuggestionComplainScreen> createState() => _SuggestionComplainScreenState();
}

class _SuggestionComplainScreenState extends State<SuggestionComplainScreen> {
  SuggestionComplainController suggestionComplainController=Get.put(SuggestionComplainController());

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  bool changeButton = false;
  String member_id="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var map = SharedPref.getPref();
    member_id = map[SpConstants.MEMBER_ID]??"";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Suggestion/Complain"),
        elevation: 0.0,
        backgroundColor: AppColors.maroonColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      //drawer: MyDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children:<Widget> [
          BgImage(),
      SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title *",style: TextStyle(color: Colors.white),),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Change this color to your desired border color
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      controller: _titleController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Enter Title",
                        contentPadding: EdgeInsets.all(10.0),
                        hintStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        border: InputBorder.none,
                        focusColor: Colors.white,


                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Title cannot be empty";
                        }
                        return null;
                      },

                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Description *",style: TextStyle(color: Colors.white),),
                  SizedBox(height: 5,),
                  Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white, // Change this color to your desired border color
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child:TextFormField(
                  controller: _descController,
                  maxLines: 4,
                  maxLength: 500,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      focusColor: Colors.white,
                      hintText: "Enter Description",
                      contentPadding: EdgeInsets.all(10.0),
                      hintStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                      border: InputBorder.none
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
                  SizedBox(height: 20,),
                  SizedBox(height: 40),
                  Padding(
                    padding:  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        Material(
                          color: AppColors.maroonColor,
                          borderRadius:
                          BorderRadius.circular(changeButton ? 50 : 8),

                          child: InkWell(
                            onTap:(){
                              if(_formkey.currentState!.validate())
                              {
                                // RegistrationUser();
                                // print("Successful");
                                if (Navigator.canPop(context)) {
                                  suggestionComplainController.addSuggestion(_titleController.text, member_id, _descController.text, context);
                                  print("***********************\n\n${member_id}\n\n*******************");
                                } else {
                                  SystemNavigator.pop();
                                }
                              }else
                              {
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              width: changeButton ? 50 : 150,
                              height: 40,
                              alignment: Alignment.center,
                              child: changeButton
                                  ? const Icon(
                                Icons.done,
                                color: Colors.white,
                              ) : const Text(
                                "SUBMIT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14

                                ),

                              ),


                            ),
                          ),
                        )

                      ],
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    )

        ],
      ),

    );
  }
}
