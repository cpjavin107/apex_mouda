import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/bg_image.dart';
import 'members.dart';
// ignore_for_file: prefer_const_constructors

class Member_Page extends StatefulWidget{
  @override
  State<Member_Page> createState() => _Member_PageState();
}

class _Member_PageState extends State<Member_Page> {
  var api = Uri.parse("http://japps.co.in/apex_mouda/nismwa_api/index.php/Member/getAllFirmOwners");
  var res, list;
  String member_id="";
   String name="",firm="",address="";
  @override
  void initState() {
    super.initState();
    fetchUserDetail();
    fetchList();
  }
  fetchUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    member_id = prefs.getString('member_id') ?? '';
  }
  fetchList() async {
    Map data = {
      'ownerId':member_id,
      'page':'1',
      'address':'',
      'deal':'',
      'block':'',
      'ownerName':'',
      'firmName':''
    };
    res = await http.post(api, body: data);
    list = jsonDecode(res.body)["data"];
   // print(list.toString());
    setState(() {});
  }
  FocusNode myFocusNode = FocusNode();
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _firmController=TextEditingController();
  final TextEditingController _addressController=TextEditingController();
   ScaffoldMessengerState? scaffoldMessenger ;
  final GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Members"),
        elevation: 0.0,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        fit: StackFit.expand,
        children:<Widget> [
          BgImage(),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _nameController,
                              onSaved: (val) {
                                name = val!;
                              },
                              onTap: (){
                                showMemberPopup(context,"1");
                                },
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: "ex. Dinesh Aggarwal",
                                labelText: "Search by Name",
                                hintStyle: TextStyle(fontSize: 14.0, color: Colors.orange),

                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.black)),
                              ),

                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: _firmController,
                            onSaved: (val) {
                              firm = val!;
                            },
                            onTap: (){
                              showMemberPopup(context,"2");
                            },
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                          //  focusNode: myFocusNode,
                            decoration: const InputDecoration(
                              hintText: "ex. ABC Pvt. Ltd.",
                              labelText: "Search by Firm Name",
                              hintStyle: TextStyle(fontSize: 14.0, color: Colors.orange),
                              // labelStyle: TextStyle(
                              //     color: myFocusNode.hasFocus ? Colors.black : Colors.black
                              // ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                            ),

                          ),
                          SizedBox(height: 20,),

                          TextFormField(
                            controller: _addressController,
                            onSaved: (val) {
                              address = val!;
                            },
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,

                            decoration: const InputDecoration(
                              hintText: "ex. a1-401",
                              labelText: "Search by Address",
                              hintStyle: TextStyle(fontSize: 14.0, color: Colors.orange),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                          ),
                          SizedBox(height: 40),
                          Padding(
                            padding:  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
                            child: Column(
                              children: [
                                Material(
                                  color: Colors.orange,
                                  borderRadius:
                                  BorderRadius.circular(changeButton ? 50 : 8),
                                  child: InkWell(
                                    onTap:(){
                                      // (_nameController.text.isEmpty&& _firmController.text.isEmpty && _addressController.text.isEmpty ) ?
                                      // print("select any one"):
                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Members_List(value :name,value1 :firm,value2: address) ));
                                      },
                                    child: AnimatedContainer(duration: Duration(seconds: 1),
                                      width: changeButton ? 50 : 150,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: changeButton ? const Icon(Icons.done, color: Colors.white,) :
                                      const Text("Apply", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
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
                  ),

                ],
              ),
            ),
          ),

        ],
      ),

    );

  }

  Future<bool> showMemberPopup(context, value) async{
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Colors.black54,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 1))
                                ],
                              ),
                              child: Icon(Icons.clear, size: 18, color: Colors.black54)),
                        ),
                      ],
                    ),
                    Divider(thickness: .1, color: Colors.black54),
                    SizedBox(
                      height: 10,
                    ),
///////////  yeha pr api  lagani h //////////////////////////////////////////////

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  SizedBox(
                        height: 500,
                        child: Flexible(
                          child: res != null ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              var data = list[index];
                              return Card(
                                color: Colors.black,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      name = '${data["name"]}';
                                    });
                                   // Member_Page();
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 8.0),
                                      decoration: BoxDecoration(
                                          border: Border(right: BorderSide(width: 1.0, color: Colors.white24))),
                                    child: CircleAvatar(backgroundImage: NetworkImage('${data["imageUrl"]}'),),),
                                    title: Text("${data["name"]}", style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold,),),
                                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("${data["firm_name"]}", style: const TextStyle(fontSize: 8, color: Colors.white,),),
                                        Text("${data["designation"]}", style: const TextStyle(fontSize: 8, color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ): CircularProgressIndicator(backgroundColor: Colors.white),
                        ),
                      ),
                    )
                    ,
                    SizedBox(

                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}