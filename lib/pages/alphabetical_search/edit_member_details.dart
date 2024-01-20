
import 'dart:convert';
import 'dart:io';

import 'package:apex_mouda/helper/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/addchild_controller.dart';
import '../../controllers/deletechild_controller.dart';
import '../../controllers/memberprofile_controller.dart';
import '../../controllers/update_member_controller.dart';
import '../../res/colors/appcolors.dart';
import '../../models/memberprofile_model.dart';
import '../member/members.dart';
// ignore_for_file: prefer_const_constructors

class Edit_detail_Page extends StatefulWidget{
  String? value;

  Edit_detail_Page({Key? key,  this.value}) : super(key : key );
  @override
  State<Edit_detail_Page> createState() => _Alpha_detail_PageState(value!);
}

MemberProfileController? profileController ;
late MemberProfileModel profileData;

Future<dynamic> getProfile(String value) async {
  profileController = Get.put(MemberProfileController());

  return   profileController?.fetchProducts(value);
}

class _Alpha_detail_PageState extends State<Edit_detail_Page> {
  String? value;
  String member_id="";
  bool changeButton = false;
  ScaffoldMessengerState? scaffoldMessenger ;
  File? imageFile;
  String imagePath= "";

  _Alpha_detail_PageState(this.value);

  @override
  void initState() {
    super.initState();
    fetchUserDetail();
  }



  imageFromGallery() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
        imageFile = File(pickedFile.path);
        uploadFile(imageFile!);
      });
    }
  }

  Future<String> convertFileToBase64(File file) async {
    if (file != null) {
      List<int> imageBytes = await file.readAsBytes();
      String base64String = await base64Encode(imageBytes);
      return base64String;
    } else {
      return "";
    }
  }
  uploadFile(File imageFile) async {
    var imageBase = await convertFileToBase64(imageFile!);
    print("**********************");
    print("***********\n\nimage/jpeg;base64,$imageBase\n\n***********");
    print("**********************");

    var url = 'http://japps.co.in/apex_mouda/nismwa_api/index.php/Member/imageUpload';
    var map = new Map<String, dynamic>();
    map['member_id'] = "$member_id";
    map['image'] = "data:image/jpeg;base64,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";
    print("**********************");
    print("***********$map***********");
    print("**********************");
    var response = await http.post(Uri.parse(url), body: map);
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['status'] == 1) {
      var jsonString = response.body;
      print("**********************");
      print("***********$jsonString***********");
      print("**********************");
      scaffoldMessenger?.showSnackBar(SnackBar(content:Text("Profile Image Updated Successfully",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green));
      Navigator.pop(context,true);
    } else {
      scaffoldMessenger?.showSnackBar(SnackBar(content:Text("try again..",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
    }
    // var uri = Uri.http('japps.co.in', '/apex_mouda/nismwa_api/index.php/Member/imageUpload');
    // var request1 = http.MultipartRequest('POST', uri)
    //   ..fields['member_id'] = member_id
    //   ..files.add(await http.MultipartFile.fromPath(
    //       'image', imagePath,));
    // var response = await request1.send();
    // if (response.statusCode == 200){
    //   scaffoldMessenger?.showSnackBar(SnackBar(content:Text("Profile Image Updated Successfully")));
    //   Navigator.pop(context,true);
    // }else{
    //   scaffoldMessenger?.showSnackBar(SnackBar(content:Text("Please try again!")));
    // }
  }



  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _memberTimeLineController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();

  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();

  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _datejoinController = TextEditingController();
  final TextEditingController _anniversaryController = TextEditingController();

  final TextEditingController _presentAddressController = TextEditingController();
  final TextEditingController _officeAddressController = TextEditingController();
  final TextEditingController _permanentAddressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
   TextEditingController _childNameController = TextEditingController();
   TextEditingController _childRemarkController = TextEditingController();

  fetchUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    member_id = prefs.getString('member_id') ?? '';
  }


  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // contentPadding: EdgeInsets.all(20),
            actionsPadding: EdgeInsets.fromLTRB(0, 0, 10, 10),
            title: Text('Add Children', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold,)),
            content: Stack(
              children: <Widget> [
                Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Children Name:"
                        , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        // onChanged: (value) {
                        //   setState(() {
                        //     name = value;
                        //   });
                        // },
                        controller: _childNameController,
                        style: const TextStyle(fontSize: 12.0,color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Enter Children Name",
                          hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.redAccent)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Children Name cannot be empty";
                          }
                          return null;
                        },

                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Reamrk
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Children Remark:"
                        , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                          // onChanged: (value) {
                          //   setState(() {
                          //     remark = value;
                          //   });
                          // } ,
                        controller: _childRemarkController,
                        style: const TextStyle(fontSize: 12.0,color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Enter Children Remark",
                          hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.redAccent)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Children Remark cannot be empty";
                          }
                          return null;
                        },

                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                ],
              ),
                
              ]
            ),
            actions: <Widget>[
              Material(
                color: Colors.red,
                borderRadius:
                BorderRadius.circular(8),
                child: InkWell(
                  onTap:() {
                    setState(() {
                      Navigator.pop(context);
                    });
                    },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width:  80 ,
                    height: 40,
                    alignment: Alignment.center,
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.green,
                borderRadius:
                BorderRadius.circular(8),
                child: InkWell(
                  onTap:() {
                    setState(() {
                      AddChild();
                      Navigator.pop(context);
                    });
                    },
                  child:  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width:  80 ,
                    height: 40,
                    alignment: Alignment.center,
                    child: const Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                      ),
                    ),
                  ),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.end
          );
        });
  }
  String? Name,Remark;
  String? name,remark;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return FutureBuilder(
        future:Future.wait([getProfile(value!)]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            profileData = snapshot.data[0];
            return Scaffold(
              appBar: AppBar(
                title: Text("Edit Details"),
                elevation: 0.0,
                backgroundColor: AppColors.maroonColor,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: Form(
                key: _formkey,
                child: Stack(
                  fit: StackFit.expand,
                  children:<Widget> [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Center(
                        child: profileData.status != 0 ?
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: profileData.data?.length,
                          itemBuilder: (context, index) {
                            _idController.text = profileData.data![index].id??"";
                            _nameController.text = profileData.data?[index].name??"";
                            _mobileController.text = profileData.data?[index].contactNumber??"";
                            _emailController.text = profileData.data?[index].email??"";
                            _memberTimeLineController.text = profileData.data?[index].executivePatronLifeMember??"";
                            _dobController.text = profileData.data?[index].dob??"";
                            _spouseNameController.text = profileData.data?[index].nameOfSpouse??"";
                            _presentAddressController.text = profileData.data?[index].presentAddress??"";
                            _officeAddressController.text = profileData.data?[index].officeAddress??"";
                            _permanentAddressController.text = profileData.data?[index].permanentAddress??"";
                            _fatherNameController.text = profileData.data?[index].fatherName??"";
                            _motherNameController.text = profileData.data?[index].motherName??"";
                            _datejoinController.text = profileData.data?[index].dateOfJoining??"";
                            _anniversaryController.text = profileData.data[index].marriageAnniversary??"";
                            _otherController.text = profileData.data?[index].anyOtherInformation??"";

                            return Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    imageFile == null ?  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(right: BorderSide(width: 1.0, color: Colors.white24))),
                                        child: Container(child: profileData.data[index].image == "" ?
                                        CircleAvatar(radius: 50.0,backgroundImage:AssetImage("assets/images/profile_icon.png"),)
                                            :
                                        CircleAvatar(radius: 50.0,backgroundImage: NetworkImage(profileData.data?[index].image??""),),),),
                                    ):Text(""),
                                     imageFile != null ? ClipRRect(
                                       borderRadius: BorderRadius.circular(48.0),
                                       child: Container(
                                        height: 100,
                                        width: 100,
                                         child:Image.file(
                                          imageFile!,
                                          fit: BoxFit.cover,
                                        ),
                                    ),
                                     ):Text(""),
                                    Padding(
                                      padding:  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Material(
                                            color: AppColors.maroonColor,
                                            borderRadius:
                                            BorderRadius.circular(changeButton ? 50 : 8),
                                            child: InkWell(
                                              onTap:() async {
                                                imageFromGallery();
                                              },
                                              child: AnimatedContainer(
                                                duration: Duration(seconds: 1),
                                                width: changeButton ? 50 : 150,
                                                height: 30,
                                                alignment: Alignment.center,
                                                child: changeButton
                                                    ? const Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ) : const Text(
                                                  "Update Image",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //members name
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Name of The Member:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _nameController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Name",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Name cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Email of The Member:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _emailController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Email",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Email cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Phone No. of The Member:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _mobileController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Email",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Phone No. cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          //executive_patron_life_member
                                          /*Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Executive/Patron/Life Member:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _memberTimeLineController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter executive_patron_life_member",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "executive_patron_life_member cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),*/
                                          //dob
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Date of Birth:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                onTap:() async{
                                                  DateTime? pickedDate = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(), //get today's date
                                                      firstDate:DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime(2101)
                                                  );
                                                  if(pickedDate !=null){
                                                    String formetdate = DateFormat("dd-MM-yyyy").format(pickedDate);
                                                    _dobController.text = formetdate.toString();

                                                  }else{
                                                    print("Date not selected");
                                                  }

                                                },
                                                readOnly: true,
                                                controller: _dobController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Date of Birth",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Date of Birth cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          //spouse
                                         /* Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                " Name of Spouse:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _spouseNameController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Spouse Name",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Spouse Name cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),*/
                                          //present address
                                         /* Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Present Address:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _presentAddressController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Present Address",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Present Address cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          //office address
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "office Address:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _officeAddressController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter office Address",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "office Address cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          //permanent address
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Permanent Address:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _permanentAddressController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Permanent Address",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Permanent Address cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          //father Name
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Father Name:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _fatherNameController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Father Name",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Father Name cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          //mother Name
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Mother Name:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _motherNameController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Mother Name",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Mother Name cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),*/
                                          //date of joining
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Date of Joining:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                enabled: false,
                                                onTap:() async{
                                                  DateTime? pickedDate = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(), //get today's date
                                                      firstDate:DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime(2101)
                                                  );
                                                  if(pickedDate !=null){
                                                    String formetdate = DateFormat("dd-MM-yyyy").format(pickedDate);
                                                    _datejoinController.text = formetdate.toString();

                                                  }else{
                                                    print("Date not selected");
                                                  }

                                                },
                                                readOnly: true,
                                                controller: _datejoinController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Joining Date",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Joining Date cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                         /* SizedBox(
                                            height: 10.0,
                                          ),

                                          //marriage Anniversary
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Marriage Anniversary:"
                                                , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                onTap:() async{
                                                  DateTime? pickedDate = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(), //get today's date
                                                      firstDate:DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime(2101)
                                                  );
                                                  if(pickedDate !=null){
                                                    String formetdate = DateFormat("dd-MM-yyyy").format(pickedDate);
                                                    _anniversaryController.text = formetdate.toString();
                                                  }else{
                                                    print("Date not selected");
                                                  }

                                                },
                                                readOnly: true,
                                                controller: _anniversaryController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Marriage Anniversary",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Marriage Anniversary cannot be empty";
                                                  }
                                                  return null;
                                                },

                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),

                                          //other
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Other:"
                                                , style: TextStyle(fontSize: 13, color: Colors.blue, fontWeight: FontWeight.bold,),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: _otherController,
                                                style: const TextStyle(fontSize: 12.0,color: Colors.black),
                                                keyboardType: TextInputType.text,
                                                decoration: const InputDecoration(
                                                  hintText: "Enter Other things",
                                                  hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.redAccent)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),*/

                                          //children
                                        /*  Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Material(
                                                color: AppColors.maroonColor,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                child: InkWell(
                                                  onTap:() {
                                                    _displayTextInputDialog(context);
                                                    },
                                                  child: AnimatedContainer(
                                                    duration: Duration(seconds: 1),
                                                    width:  55 ,
                                                    height: 25,
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      "Add Child",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 9
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),


                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Children:"
                                                    , style: TextStyle(fontSize: 13, color: AppColors.maroonColor, fontWeight: FontWeight.bold,),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            physics: BouncingScrollPhysics(),
                                            child: Container(
                                              height: 200,
                                              child: Childrens(profileData.data[index].childrenDetails!),
                                            ),
                                          ),*/




                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding:  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Material(
                                            color: Colors.blue,
                                            borderRadius:
                                            BorderRadius.circular(changeButton ? 50 : 8),
                                            child: InkWell(
                                              onTap:() {
                                               print(imageFile);
                                               if(_formkey.currentState!.validate())
                                               {
                                                  UpdateMemeberDetails();
                                                  print("Successful");
                                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Members_List() ));

                                               }else
                                               {
                                                 // print("Unsuccessfull");
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
                                          ),


                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                              ),

                            );

                          },
                        ):
                        Text("Member profile not found!", style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold,),),

                      ),
                    )
                  ],

                ),
              ),
              //   bottomNavigationBar: Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child:
              //   InkWell(
              //       onTap: (){
              //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => Big_Image(value :'${ads[0]["big_image"]}',) ));
              //         },
              //       child: Image.network('${ads[0]["small_image"]}',)),
              // ),

            );
          }else{
            return Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        }
    );

  }


  Future UpdateMemeberDetails()  async{
    UpdateMemberController enquiryController ;
    enquiryController = Get.put(UpdateMemberController());
    SharedPref.setMemberName(_nameController.text);
    return enquiryController.fetchProducts(_idController.text,_nameController.text,
        _memberTimeLineController.text,_spouseNameController.text,_fatherNameController.text,_motherNameController.text,
        _dobController.text,_datejoinController.text,_anniversaryController.text,_presentAddressController.text,
        _officeAddressController.text,_permanentAddressController.text,_mobileController.text,_emailController.text,_otherController.text);

  }

  Future AddChild() async {
    AddChildController enquiryController ;
    enquiryController = Get.put(AddChildController());
    return enquiryController.fetchProducts(_idController.text,_childNameController.text,_childRemarkController.text);

  }

  Future DeleteChild(String? id) {
    DeleteChildController enquiryController;
    enquiryController = Get.put(DeleteChildController());
    return enquiryController.fetchProducts(id!);
  }

  Childrens(List<ChildrenDetails> childrenDetails) {
    return ListView.builder(
        itemCount:childrenDetails.length,
        itemBuilder: (BuildContext context,int index){
          return  Card(
            color: Colors.grey[50],
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(childrenDetails[index].name??"", style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  SizedBox(height: 2,),
                  Text( childrenDetails[index].remark??"", style: TextStyle(
                    fontSize: 9,
                    color: Colors.black,
                  ),
                  ),
                  SizedBox(height: 2,),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(icon: new Icon(Icons.delete,size: 20.0,color: Colors.red,),
                        onPressed: () {
                          setState(() {
                            DeleteChild(childrenDetails[index].id);
                           // Navigator.pop(context);
                          });


                        },)

                  ),


                ],
              ),
            ),
          );

        }

    );
  }

}





