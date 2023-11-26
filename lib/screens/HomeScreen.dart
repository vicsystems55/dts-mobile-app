import 'package:flutter/material.dart';
import 'package:fmfdts/screens/Notifications.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fullName = "John Doe";
  // Replace with the user's full name
  final int totalSubmitted = 10;
  // Replace with the actual total submitted count
  final int totalApproved = 5;
  // Replace with the actual total approved count
  final List<String> recentActivities = [
    "Your submission for X was approved.",
    "You have submitted a new document.",
    // Add more recent activities here
  ];

  late Box user_info;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  Future<dynamic> getUserInfo() async {
    user_info = await Hive.openBox('data');

    fullName = user_info.get('name');

    setState(() {});


    print(fullName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hi, $fullName', style: TextStyle(fontSize: 24)),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsScreen()),
                  )
                },
                color: Colors.green,
                iconSize: 24,
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCard('Total Submitted', totalSubmitted.toString()),
              _buildCard('Total Approved', totalApproved.toString()),
            ],
          ),
          SizedBox(height: 20),
          Text('Recent Activities', style: TextStyle(fontSize: 20)),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: recentActivities.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(recentActivities[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String count) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(count,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String message) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          //set border radius more than 50% of height and width to make circle
        ),
        elevation: 2,
        child: ListTile(
          leading: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.blue, // Replace with your desired color for the dot
              shape: BoxShape.circle,
            ),
          ),
          title: Text(message),
        ),
      ),
    );
  }
}
