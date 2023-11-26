import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrackScreen extends StatefulWidget {
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  bool isLoading = false;

  List<String> filteredData = [];

  @override
  void initState() {
    // Initialize filtered data with all the data initially.
    super.initState();
  }

  Future<void> _refreshList() async {
    // Simulate a data refresh, you can fetch new data here if you have an API call.
    await Future.delayed(Duration(seconds: 2));
    // setState(() {
    //   filteredData = searchData.where((item) =>
    //       item.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
     
        children: [
          SizedBox(
            height: 100,
          ),
          Text('Track My Submission', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Container(
            height: 50,
            child: TextField(
              // onChanged: _filterData,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.send),
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
          // Sign in button
          Container(
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                TextInput.finishAutofillContext();

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => DashboardPage()),
                // );
              },
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Check Status',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
