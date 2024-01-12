
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/members_controller.dart';
import '../../res/colors/appcolors.dart';
import '../../models/member_model.dart';
import '../alphabetical_search/list_user_details.dart';
// ignore_for_file: prefer_const_constructors

class Members_List extends StatefulWidget{
  String? value,value1,value2;

  @override
  State<Members_List> createState() => _Members_ListState();
}

MemberController? memberController ;

Future<dynamic> getMembers() async {
  memberController = Get.put(MemberController());
  return   memberController?.fetchProducts();
}

class _Members_ListState extends State<Members_List> with TickerProviderStateMixin{
   String? value,value1,value2;
  _Members_ListState();
  String check ="1";

   List<Data> memberData = [];
   List<Data>  memberData2=[];
   final TextEditingController _typeAheadController = TextEditingController();

   _getRequests()async{
     setState(() {});
   }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
       future:Future.wait([getMembers()]),
       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
         if(snapshot.hasData){
           memberData = snapshot.data[0];
         //  memberData2 = snapshot.data[0];
           return Scaffold(
               appBar: AppBar(
                 title: Text('Members'),
                 elevation: 0.0,
                 backgroundColor: AppColors.maroonColor,
                 iconTheme: IconThemeData(color: Colors.white),
               ),
               body: Stack(
                 fit: StackFit.expand,
                 children:<Widget> [
                   Center(
                           child: Column(
                             children: [
                               Padding(
                                 padding:  EdgeInsets.all(8.0),
                                 child: SizedBox(
                                   height: 45,
                                   child: TextField(
                                     onChanged: (value) {

                                       List<Data> dummySearchList = [];
                                       dummySearchList.addAll(memberData);
                                       if(value.isNotEmpty) {
                                         List<Data> dummyListData = [];
                                         dummySearchList.forEach((item) {
                                           if(item.name!.contains(value)) {
                                             dummyListData.add(item);
                                           }
                                         });
                                         setState(() {
                                           memberData2.clear();
                                           memberData2.addAll(dummyListData);
                                           check = "2";

                                         });
                                         return ;
                                       } else {
                                         setState(() {
                                           memberData2.clear();
                                           memberData2.addAll(memberData);
                                           check = "2";
                                         });
                                       }
                                     },
                                     controller: _typeAheadController,
                                     decoration: InputDecoration(
                                         labelText: "Search",
                                         hintText: "Search",
                                         prefixIcon: Icon(Icons.search),
                                         labelStyle: TextStyle( fontSize: 12 , fontFamily: 'Normal',),
                                         hintStyle: TextStyle( fontSize: 12 , fontFamily: 'Normal',),
                                         border: OutlineInputBorder(
                                             borderRadius: BorderRadius.all(Radius.circular(10.0))
                                         )
                                     ),
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 height: 10,
                               ),
                               Expanded(
                                 child:check =="1"?
                                 ListView.builder(
                                     itemCount:memberData.length,
                                     itemBuilder: (BuildContext context,int index){
                                       return Padding(
                                         padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 4.0),
                                         child: Column(
                                           children: [
                                             Card(
                                               elevation: 1,
                                               child: InkWell(
                                                 onTap: () {
                                                   Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new Alpha_detail_Page(value :memberData[index].id,)),)
                                                       .then((val)=>{_getRequests()});
                                                 //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Alpha_detail_Page(value :memberData2[index].id,) ));
                                                 },
                                                 child: ClipPath(
                                                   child:  Container(
                                                     height: 80,
                                                     decoration: BoxDecoration(
                                                         border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                                                     child: Column(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         Row(
                                                           children: [
                                                             Padding(
                                                               padding: const EdgeInsets.all(8.0),
                                                               child: Container(
                                                                 decoration: BoxDecoration(
                                                                     border: Border(right: BorderSide(width: 1.0, color: Colors.white24))),
                                                                 child: Container(child: memberData[index].image == "" ?
                                                                 CircleAvatar(backgroundImage:AssetImage("assets/images/profile_icon.png"),)
                                                                     :
                                                                 CircleAvatar(radius: 30.0,backgroundImage: NetworkImage(memberData[index].image??""),),),),
                                                             ),
                                                              Expanded(
                                                               child: Column(
                                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                 children: [
                                                                   Container(
                                                                     padding: EdgeInsets.all(4),
                                                                     child:  Text(
                                                                       memberData[index].name??"",
                                                                       maxLines: 2,
                                                                       overflow: TextOverflow.clip,
                                                                       style:
                                                                       TextStyle(fontSize: 14,
                                                                           color: Colors.black,
                                                                           fontFamily: 'Bolds', fontWeight: FontWeight.w800)
                                                                       ,
                                                                     ),

                                                                   ),
                                                                   Container(
                                                                     padding: EdgeInsets.all(4),
                                                                     child:  Text(
                                                                       memberData[index].email??"",
                                                                       maxLines: 2,
                                                                       overflow: TextOverflow.clip,
                                                                       style:
                                                                       TextStyle(fontSize: 12,
                                                                           color: Colors.black,
                                                                           fontFamily: 'Normal',)
                                                                       ,
                                                                     ),

                                                                   )
                                                                 ],
                                                               ),
                                                             )
                                                           ],

                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                   clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                                                       borderRadius: BorderRadius.circular(4))),
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       );
                                     }
                                  ):
                                 ListView.builder(
                                     itemCount:memberData2.length,
                                     itemBuilder: (BuildContext context,int index){
                                       return Padding(
                                         padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 4.0),
                                         child: Column(
                                           children: [
                                             Card(
                                               elevation: 1,
                                               child: InkWell(
                                                 onTap: () {
                                                   Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new Alpha_detail_Page(value :memberData2[index].id,)),)
                                                       .then((val)=>{_getRequests()});
                                                 //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Alpha_detail_Page(value :memberData2[index].id,) ));
                                                 },
                                                 child: ClipPath(
                                                   child:  Container(
                                                     height: 80,
                                                     decoration: BoxDecoration(
                                                         border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                                                     child: Column(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         Row(
                                                           children: [
                                                             Padding(
                                                               padding: const EdgeInsets.all(8.0),
                                                               child: Container(
                                                                 decoration: BoxDecoration(
                                                                     border: Border(right: BorderSide(width: 1.0, color: Colors.white24))),
                                                                 child: Container(child: memberData2[index].image == "" ?
                                                                 CircleAvatar(backgroundImage:AssetImage("assets/images/profile_icon.png"),)
                                                                     :
                                                                 CircleAvatar(radius: 30.0,backgroundImage: NetworkImage(memberData2[index].image??""),),),),
                                                             ),
                                                              Expanded(
                                                               child: Column(
                                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                 children: [
                                                                   Container(
                                                                     padding: EdgeInsets.all(4),
                                                                     child:  Text(
                                                                       memberData2[index].name??"",
                                                                       maxLines: 2,
                                                                       overflow: TextOverflow.clip,
                                                                       style:
                                                                       TextStyle(fontSize: 14,
                                                                           color: Colors.black,
                                                                           fontFamily: 'Bolds', fontWeight: FontWeight.w800)
                                                                       ,
                                                                     ),

                                                                   ),
                                                                   Container(
                                                                     padding: EdgeInsets.all(4),
                                                                     child:  Text(
                                                                       memberData2[index].email??"",
                                                                       maxLines: 2,
                                                                       overflow: TextOverflow.clip,
                                                                       style:
                                                                       TextStyle(fontSize: 12,
                                                                           color: Colors.black,
                                                                           fontFamily: 'Normal',)
                                                                       ,
                                                                     ),

                                                                   )
                                                                 ],
                                                               ),
                                                             )
                                                           ],

                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                   clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                                                       borderRadius: BorderRadius.circular(4))),
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       );
                                     }
                                  ),
                               ),
                             ],
                           )
                       ),
                 ],
               )
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

