import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late Box notifications_bck;
  late Box user_data;


  List notifications = [];
  String username = '';
  String token = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  Future<dynamic> getProducts() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    user_data = await Hive.openBox('data');
    notifications_bck = await Hive.openBox('notifications_bck');

    setState(() {});

    String url = "https://dtsapi.icreateagency.com/api/notifications";

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // ignore: prefer_interpolation_to_compose_strings
          'Authorization': 'Bearer ' + user_data.get('token')
        },
      );
      print('got products');
      var _jsonDecode = await jsonDecode((response.body));

      print(_jsonDecode);

      await putData(_jsonDecode);
    } catch (SocketException) {
      print(SocketException);
    }

    var mymap2 = notifications_bck.toMap().values.toList();

    if (mymap2 == null) {
      notifications.add('empty');
    } else {
      notifications = mymap2;
      print(notifications);
    }

    // return Future.value(true);
  }

  Future putData(data) async {


    await notifications_bck.clear();
    for (var d in data) {
      notifications_bck.add(d);
    }
    setState(() {});
  }

  Future<void> _refreshNotifications() async {
    // Simulate a data refresh, you can fetch new data here if you have an API call.
    await Future.delayed(Duration(seconds: 2));
    setState(() {
    
    });
  }

  Future<void> _loadMoreNotifications() async {
    // Simulate loading more data, you can fetch more data here if you have an API call.
    await Future.delayed(Duration(seconds: 2));
    setState(() {
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: getProducts,
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(notifications[index]['subject']),
                  subtitle: Text(notifications[index]['msg']),
                  // Add more notification details as needed
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _loadMoreNotifications,
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

