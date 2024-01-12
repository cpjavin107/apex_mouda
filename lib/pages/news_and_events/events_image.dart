import 'package:flutter/material.dart';
import 'package:apex_mouda/models/news_model.dart';

import '../../res/colors/appcolors.dart';

// ignore_for_file: prefer_const_constructors

class Event_Images extends StatefulWidget{
  List<Images>? value;
  Event_Images({Key? key,  this.value}) : super(key : key );

  @override
  State<Event_Images> createState() => _Event_ImagesState(value!);
}
class _Event_ImagesState extends State<Event_Images> {
  List<Images> value;

  _Event_ImagesState(this.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(  appBar: AppBar(
      title: Text("Events & News"),
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
                                child: value != null ? ListView.builder(
                                       itemCount: value.length,
                                          itemBuilder: (context, index) {
                                              return Card(
                                               color: Colors.white,
                                                child: InkWell(
                                                      child: Column(
                                                        children: [
                                                         Image.network(value[index].image??""),
                                                         ],
                                                    ),
                                                ),
                                             );
                                       },
                                   ): CircularProgressIndicator(backgroundColor: Colors.white),
                               ),
                        )
                    ],

               )
         );

  }
}