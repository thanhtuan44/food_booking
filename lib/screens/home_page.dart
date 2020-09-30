import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_booking/screens/cart/cart_page.dart';
import 'package:food_booking/screens/dashboard/dashboard_page.dart';
import 'package:food_booking/screens/nearby/nearby_page.dart';
import 'package:food_booking/screens/profile/profile_page.dart';
import 'package:food_booking/shared/widget/navigation/navigation_bar.dart';
import 'package:food_booking/shared/widget/navigation/navigation_bar_item.dart';
import 'package:food_booking/shared/widget/scale_animation.dart';



class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final HomePageState mainState = HomePageState();
  HomePageState createState() => mainState;

}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _tabSelected = false;
  bool spinLoading = false;
  Widget _customPage;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pageItems = <Widget>[
    DashBoardPage(),
    NearByPage(),
    CartPage(),
    ProfilePage(),
  ];



  @override
  void initState() {
    super.initState();
    _tabSelected = true;
  }


  TabController tabController;
  @override
  Widget build(BuildContext context)
  {
    if(tabController == null) {
      tabController = new TabController(length: _pageItems.length, vsync: this);
    }


    var mainScreen = Container(
      child: WillPopScope(
        child: Scaffold(
            key: _scaffoldKey,
            body: _pageItems.elementAt(_selectedIndex),
            bottomNavigationBar: TitledBottomNavigationBar(
                currentIndex: _selectedIndex,
                isHighlight: _tabSelected,
                onTap: (index){
                  setState(() {
                    _selectedIndex = index;
                    _tabSelected = true;
                  });
                },
                items: [
                  TitledNavigationBarItem(title: 'Home', icon: "icon_tab_tuclass", showBadge: false, badgeContent: ""),
                  TitledNavigationBarItem(title: 'Near By', icon: "icon_tab_knowledge", showBadge: false, badgeContent: ""),
                  TitledNavigationBarItem(title: 'Cart', icon: "icon_tab_exam", showBadge: false, badgeContent: ""),
                  TitledNavigationBarItem(title: 'Profile', icon: "icon_tab_statistics", showBadge: false, badgeContent: ""),
                ]
            )
        ), onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return new Future(() => false);
      },
      ),
    );

    return Stack(
      children: <Widget>[
        mainScreen,
        spinLoading ? Container(
          color: Colors.black12,
          child: Center(
              child: ScaleAnimation(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: new BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: SpinKitCircle(
                    color: Colors.white,
                  ),
                ),
              )
          ),
        ) : Container(width: 0, height: 0,),
      ],
    );
  }
}
