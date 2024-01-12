import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../res/colors/appcolors.dart';

// ignore_for_file: prefer_const_constructors

class Notification_list extends StatefulWidget{
  String? value;
  Notification_list({Key? key,  this.value}) : super(key : key );

  @override
  State<Notification_list> createState() => _Notification_listState(value!);
}

class _Notification_listState extends State<Notification_list> {
  String value;
  _Notification_listState(this.value);
  var api = Uri.parse("http://japps.co.in/apex_mouda/nismwa_api/index.php/Member/getNotificationList");
  var res, list;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    print(value);
    Map data = {
      'page':'1',
      'id':value,
    };
    res = await http.post(api, body: data);
    list = jsonDecode(res.body)["data"];
    //print(list.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
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
              child: res != null ? ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var data = list[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( "${data["title"]}", style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                           SizedBox(height: 10,),

                          Text( "${data["description"]}", style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            width: double.infinity,
                            child:   Text( "${data["insertDate"]}", textAlign: TextAlign.right,style: TextStyle(
                              fontSize: 10,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  );

                },
              ): Center(
                child: Text(
                  "Notification Not Found!",style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),
                ),
              ),
            ),
          )
        ],

      ),

    );
  }
}