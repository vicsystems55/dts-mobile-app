import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fmfdts/screens/HomeScreen.dart';
import 'package:fmfdts/screens/ProfileScreen.dart';
import 'package:fmfdts/screens/SubmissionScreen.dart';
import 'package:fmfdts/screens/TrackScreen.dart';

class DashboardPage extends StatefulWidget {
  final String newReg;

  DashboardPage({required this.newReg});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void _showAlert()  {
    if (widget.newReg == 'yes') {
       Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        icon: const Icon(
          Icons.check,
          color: Colors.green,
        ),
        title: "Registration Successful",
        message: "Welcome on board",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showAlert();
  }

  int _currentPageIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          HomeScreen(),
          SubmissionsScreen(),
          TrackScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey, // Set the color for unselected items
        selectedItemColor: Colors.green, // Set the color for selected item
        showUnselectedLabels:
            true, // Set this to true to show labels for unselected items
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_upload),
            label: 'Submissions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
