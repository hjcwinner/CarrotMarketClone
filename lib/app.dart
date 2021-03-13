import 'package:CarrotMarketClone/faovrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  
  int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  Widget _bodywd() {
    switch (_currentPageIndex) {
      case 0:
        return Home();
        break;
      case 1:
        return Container();
        break;
      case 2:
        return Container();
        break;
      case 3:
        return Container();
        break;
      case 4:
        return Favorite();
        break;
      default:
        Container();
    }
  }

  BottomNavigationBarItem _bottomicon(String iconname, String labelname) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: SvgPicture.asset(
          "assets/svg/${iconname}_off.svg",
          width: 20,
        ),
      ),
      label: labelname,
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: SvgPicture.asset(
          "assets/svg/${iconname}_on.svg",
          width: 20,
        ),
      ),
    );
  }

  Widget _bottomnvbar() {
    return BottomNavigationBar(
      items: [
        _bottomicon("home", "HOME"),
        _bottomicon("notes", "동네생활"),
        _bottomicon("location", "내 근처"),
        _bottomicon("chat", "채팅"),
        _bottomicon("user", "나의 당근")
      ],
      onTap: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      currentIndex: _currentPageIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodywd(),
      bottomNavigationBar: _bottomnvbar(),
    );
  }
}
