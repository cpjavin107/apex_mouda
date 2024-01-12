
import 'package:apex_mouda/pages/news_and_events/event_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:apex_mouda/res/routes/my_routes.dart';
import '../../pages/alphabetical_search/alphabet_list.dart';
import '../../pages/alphabetical_search/list_user_details.dart';
import '../../pages/committee/main_page.dart';
import '../../pages/enquiry/add_enquiry_page.dart';
import '../../pages/enquiry/enquiry.dart';
import '../../pages/holiday/holidat_list.dart';
import '../../pages/home/home_page.dart';
import '../../pages/login_pages.dart';
import '../../pages/member/members.dart';
import '../../pages/news_and_events/news_page.dart';
import '../../pages/select_page.dart';
import '../../pages/splase.dart';
import '../../pages/useful_details/select_useful_details.dart';
import '../../widgets/splase_ads.dart';

class NamedRoutes{


  static Map<String, Widget Function(BuildContext)> routeMap  = {
    MyRoutes.splaseRoute: (context) => SplashScreen(),
    MyRoutes.loginRoute: (context) => LoginPage(),
    MyRoutes.seleteHome: (context) => Home_Page(),
    MyRoutes.seleteenquiry: (context) => Enquiry(),
    MyRoutes.addenquiry: (context) => Add_Enquiry(),
    MyRoutes.selectUseful: (context) => Useful_Page(),
    MyRoutes.news: (context) => News_Page(),
    MyRoutes.event: (context) => Event_Page(),
    MyRoutes.viewholiday: (context) => HoliDay_Page(),
    MyRoutes.alphasearch: (context) => Alphabet_List(),
    MyRoutes.members: (context) => Members_List(),
    MyRoutes.committee: (context) => Main_page_Committee(),
    MyRoutes.adsImage : (context) => Ads_Image(),
    MyRoutes.selectLoginOrGuest : (context) => Select(),
    MyRoutes.profile : (context) => Alpha_detail_Page(),
    // MyRoutes.alphasearchData: (context) => Alphabet_Search_Page(),
    // MyRoutes.alphasearchDataDetails: (context) => Alpha_detail_Page(),
    //MyRoutes.members: (context) => Member_Page(),

  };
}