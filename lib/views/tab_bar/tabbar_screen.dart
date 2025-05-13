import 'package:client_app/views/home/home.dart';
import 'package:client_app/views/persional_info/persional_info.dart';
import 'package:client_app/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({super.key});

  @override
  State<TabbarScreen> createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  late List<Widget> _widgetOptions; // Widget options for navigation
  bool _isLoading = true; // To indicate if data is still loading
  int _selectedIndex = 0;

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.person_rounded,
  ];

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    _initializeWidgetOptions(); // Initialize widget options
    setState(() {
      _isLoading = false; // Mark loading as complete
    });
  }

  void _initializeWidgetOptions() {
    _widgetOptions = <Widget>[
      Home(),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(listOfIcons.length, (index) {
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300), // Reduced duration
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.only(
                      bottom: index == _selectedIndex ? size.width * .014 : 0,
                    ),
                    decoration: BoxDecoration(
                      color: index == _selectedIndex
                          ? Colors.blueAccent
                          : Colors.transparent,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                  Icon(
                    listOfIcons[index],
                    size: size.width * .076,
                    color: index == _selectedIndex
                        ? Colors.blueAccent
                        : Colors.black38,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

// BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.teal,
      //   onTap: _onItemTapped,
      // ),
