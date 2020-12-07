import 'package:flutter/material.dart';
import 'package:health_care/device/add_device_page.dart';
import 'package:health_care/main/detail_page.dart';
import 'package:health_care/main/home_page.dart';
import 'package:health_care/main/user_list_screen.dart';
import 'package:health_care/main/user_profile_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.loginResponse}) : super(key: key);

  final Map loginResponse;

  @override
  _HomeScreenState createState() => _HomeScreenState(loginResponse);
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState(this.loginResponse);

  final Map loginResponse;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions;
  static List<BottomNavigationBarItem> bottomBarItems;

  @override
  void initState() {
    print('_HomeScreenState.initState: $loginResponse');
    loginResponse['quyen'] = 0;

    initBottomBarItems(0);
    initWidgetOptions(0);

    super.initState();
  }

  void initBottomBarItems(int quyen) {
    bottomBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.details),
        label: 'Cảnh báo',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu),
        label: 'Danh sách',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'Thêm',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_box_outlined),
        label: 'Cá nhân',
      ),
    ];
  }

  void initWidgetOptions(int quyen) {
    _widgetOptions = <Widget>[
      loginResponse['quyen'] == 1
          ? HomePage(
              loginResponse: loginResponse,
            )
          : UserListScreen(),
      DetailPage(
        loginResponse: loginResponse,
      ),
      AddDevice(
        'iduser',
        'idnha',
        'idphong',
        1,
      ),
      UserProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget buildBody() {
    return Container(
      child: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  Widget bottomBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: Colors.blue,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Colors.red,
        textTheme: Theme.of(context).textTheme.copyWith(
              caption: new TextStyle(color: Colors.white),
            ),
      ),
      child: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: bottomBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
