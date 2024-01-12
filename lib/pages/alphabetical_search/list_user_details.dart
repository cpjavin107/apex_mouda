
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../../controllers/memberprofile_controller.dart';
import '../../res/colors/appcolors.dart';
import '../../models/memberprofile_model.dart';
import 'edit_member_details.dart';
// ignore_for_file: prefer_const_constructors

class Alpha_detail_Page extends StatefulWidget{
  String? value;

  Alpha_detail_Page({Key? key,  this.value}) : super(key : key );
  @override
  State<Alpha_detail_Page> createState() => _Alpha_detail_PageState(value!);
}

MemberProfileController? profileController ;
late MemberProfileModel profileData;

Future<dynamic> getProfile(String value) async {
  profileController = Get.put(MemberProfileController());

  return   profileController?.fetchProducts(value);
}

class _Alpha_detail_PageState extends State<Alpha_detail_Page> {
  String value;
  String member_id="";
  bool check=false;
  var dob="";
  var doj="";
  _Alpha_detail_PageState(this.value);
  dateFormate(var userdate) async{
    var date= await DateTime.parse("$userdate");
    var value=await DateFormat('dd-MMM-yyyy').format(date);
    return value;
  }
  @override
  void initState() {
    super.initState();
    fetchUserDetail();
  }

  fetchUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    member_id = prefs.getString('member_id') ?? '';
  }
  _getRequests()async{

    setState(() {});

  }

  getData()async{
    dob= await dateFormate(profileData.data[0].dob);
    doj= await dateFormate(profileData.data[0].dateOfJoining);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:Future.wait([getProfile(value)]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData) {
            profileData = snapshot.data[0];
            getData();
            return Scaffold(
              appBar: AppBar(
                title: Text("Member Details"),
                elevation: 0.0,
                backgroundColor: AppColors.maroonColor,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: Stack(
                fit: StackFit.expand,
                children:<Widget> [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  Center(
                      child: profileData.status != 0 ?
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: profileData.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  member_id != "" ? Row(
                                    children: [
                                      member_id == profileData.data[index].id ? Container(
                                          child:  IconButton(
                                              onPressed: () async {
                                               // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Edit_detail_Page(value :profileData.data[index].id,) ));
                                                Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new Edit_detail_Page(value :profileData.data[index].id,)),)
                                                    .then((val)=>{_getRequests()});
                                              },
                                              icon: Icon(Icons.edit,size: 30, color:Colors.red)
                                          ),
                                      ):Text(""),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.end,
                                  ):Text(""),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(right: BorderSide(width: 1.0, color: Colors.white24))),
                                      child: Container(child: profileData.data[index].image == "" ?
                                      CircleAvatar(radius: 50.0,backgroundImage:AssetImage("assets/images/profile_icon.png"),)
                                          :
                                      CircleAvatar(radius: 50.0,backgroundImage: NetworkImage(profileData.data[index].image??""),),),),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                     /*       SingleChildScrollView(
                                               scrollDirection: Axis.horizontal,
                                                   child:  Row(
                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                     mainAxisAlignment: MainAxisAlignment.center,
                                                     children: [
                                                       Text(profileData.data[index].nameOfTheMember!
                                                           +" || "+profileData.data[index].executivePatronLifeMember!,
                                                         style: const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold,)
                                                         ,maxLines: 2,),

                                                     ],
                                                   ),

                                          ),
                                      Text("Date Of Birth : "+profileData.data[index].dob!, style: const TextStyle(fontSize: 9, color: Colors.black,),),
                                      Text("Spouse Name : "+profileData.data[index].nameOfSpouse!, style: const TextStyle(fontSize: 10, color: Colors.black),),
                                      */
                                      Text(profileData.data[index].name!, style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold,),),
                                      SizedBox(height: 5,),
                                      Text(profileData.data[index].email!, style: const TextStyle(fontSize: 14, color: Colors.black,),),

                                    ],
                                  ),
                                  const Divider(color: AppColors.maroonColor,thickness: 3,height: 50,),
                                  SizedBox(height: 20,),
                                  ListTile(
                                    onTap: () {
                                      // launch('tel:${profileData.data[index].contactNumber}');
                                    },
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: Icon(Icons.person_outline, color: Colors.purple),
                                    ),
                                    title: Text("Designation:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  Text(
                                      profileData.data[index].executiveMemberDesignation.length>0? "${profileData.data[index].executiveMemberDesignation[0].name}  ":"",
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style:
                                      TextStyle(fontSize: 12,
                                        color: Colors.black,
                                        fontFamily: 'Normal',),
                                    ),

                                  ),
                                  const Divider(color: AppColors.maroonColor),
                                  ListTile(
                                    onTap: () {

                                      if(!check){
                                        setState(() async{
                                           check= await true;
                                          await launch('tel:${profileData.data[index].contactNumber}');
                                          check=false;
                                        });
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please await..")));
                                      }

                                    },
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: Icon(Icons.smartphone, color: Colors.purple),
                                    ),
                                    title: Text("Mobile:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  Text(profileData.data[index].contactNumber!, style: const TextStyle(fontSize: 12, color: Colors.black,),),
                                    trailing: Icon(Icons.call,size: 30, color:Colors.blueAccent),
                                  ),
                                  const Divider(color: AppColors.maroonColor),
                                  ListTile(
                                    onTap: () {
                                      if(!check){
                                        setState(() async{
                                          check= await true;
                                          await launch('mailto:${profileData.data[index].email}');
                                          check=false;
                                        });
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please await..")));
                                      }

                                    },
                                    leading: Container(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: const Icon(Icons.mail, color: Colors.red),
                                    ),
                                    title: Text("E-mail:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  Text(profileData.data[index].email??"", style: const TextStyle(fontSize: 12, color: Colors.black,),),
                                    trailing: Icon(Icons.forward_to_inbox,size: 30, color:Colors.redAccent),
                                  ),
                                  // const Divider(color: AppColors.maroonColor,),
                                  /*ListTile(
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDe

                                       coration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: Icon(Icons.location_on, color: Colors.green),
                                    ),
                                    title: Text("Office Address:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  Text(profileData.data[index].officeAddress??"", style: const TextStyle(fontSize: 10, color: Colors.black,),),
                                  ),
                                  const Divider(color: AppColors.maroonColor,),
                                  ListTile(

                                    leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: Icon(Icons.business, color: Colors.orange),
                                    ),
                                    title: Text("Permanent Address:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  Text(profileData.data[index].permanentAddress??"", style: const TextStyle(fontSize: 10, color: Colors.black,),),
                                  ),
                                  const Divider(color: AppColors.maroonColor),
                                  ListTile(
                                    leading: Container(

                                      padding: const EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: const Icon(Icons.person, color: Colors.blueAccent),
                                    ),
                                    title: Text("Father Name:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  Text(profileData.data[index].fatherName??"", style: const TextStyle(fontSize: 10, color: Colors.black,),),
                                  ),*/
                                  /*const Divider(color: AppColors.maroonColor),
                                  ListTile(
                                    leading: Container(

                                      padding: const EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: const Icon(Icons.woman, color: Colors.pink),
                                    ),
                                    title: Text("Mother Name:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  Text(profileData.data[index].motherName??"", style: const TextStyle(fontSize: 10, color: Colors.black,),),
                                  ),*/
                                  const Divider(color: AppColors.maroonColor),
                                  ListTile(
                                    leading: Container(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: const Icon(Icons.calendar_today, color: Colors.blue),
                                    ),
                                    title: Text("Date Of Birth:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  Text("$dob"??"", style: const TextStyle(fontSize: 12, color: Colors.black,),),
                                  ),
                                  const Divider(color: AppColors.maroonColor),
                                  ListTile(
                                    leading: Container(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: const Icon(Icons.calendar_today, color: Colors.amber),
                                    ),
                                    title: Text("Date Of Joining:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  Text("$doj"??"", style: const TextStyle(fontSize: 12, color: Colors.black,),),
                                  ),
                                /*  const Divider(color: AppColors.maroonColor),
                                  ListTile(
                                    leading: Container(

                                      padding: const EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: const Icon(Icons.calendar_month, color: Colors.teal),
                                    ),
                                    title: Text("Marriage Anniversary:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  Text(profileData.data[index].marriageAnniversary??"", style: const TextStyle(fontSize: 10, color: Colors.black,),),
                                  ),*/
                                /*  const Divider(color: AppColors.maroonColor),
                                  ListTile(
                                    leading: Container(

                                      padding: const EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(width: 1.0, color: Colors.black))),
                                      child: const Icon(Icons.child_care, color: Colors.black),
                                    ),
                                    title: Text("Children:", style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold,),),
                                    subtitle:  SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      physics: BouncingScrollPhysics(),
                                      child: Container(
                                        height: 180,
                                        child: Childrens(profileData.data[index].childrenDetails!),
                                      ),
                                    ),
                                  ),*/


                                  // Container(
                                  //     child:  member_id == value ? Visibility(
                                  //       visible: false,
                                  //       child:   ListTile(
                                  //         title: Row(
                                  //           children: <Widget>[
                                  //             Expanded(child: ElevatedButton(onPressed: () {},
                                  //                 child: SizedBox(child: Text("Add to Contact")))),
                                  //             SizedBox(width: 10,),
                                  //             // Expanded(child: ElevatedButton(onPressed: () async {
                                  //             //   await launch ("https://wa.me/918743007244?text=Hello");
                                  //             // },child:  SizedBox(child: Text("Share Contact")),)),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ):
                                  //     Visibility(
                                  //       visible: true,
                                  //       child:     ListTile(
                                  //         title: Row(
                                  //           children: <Widget>[
                                  //             Expanded(child: ElevatedButton(onPressed: () {
                                  //             }, child: SizedBox(child: Text("Add to Contact")))),
                                  //             SizedBox(width: 10,),
                                  //             Expanded(child: ElevatedButton(onPressed: () async {
                                  //               await launch ("https://wa.me/918743007244?text=Hello");
                                  //             },child:  SizedBox(child: Text("Share Contact")))),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     )
                                  // ),

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
}

Childrens(List<ChildrenDetails> childrenDetails) {
  return ListView.builder(
      itemCount:childrenDetails.length,
      itemBuilder: (BuildContext context,int index){
        return  Card(
          color: Colors.grey[50],
          child: Padding(
            padding: const EdgeInsets.all( 8.0),
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



              ],
            ),
          ),
        );

      }

  );
}