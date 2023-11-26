import 'package:flutter/material.dart';
import 'package:fmfdts/screens/CreateSubmission.dart';

class SubmissionsScreen extends StatefulWidget {
  @override
  _SubmissionsScreenState createState() => _SubmissionsScreenState();
}

class _SubmissionsScreenState extends State<SubmissionsScreen> {
  List<String> searchData = [
    'Title 1',
    'Title 2',
    'Title 3',
    // Add more data as needed
  ];

  List<String> officeSubmittedData = [
    'Office A',
    'Office B',
    'Office C',
    // Add more data as needed
  ];

  List<String> dateData = [
    '2023-08-01',
    '2023-08-02',
    '2023-08-03',
    // Add more data as needed
  ];

  List<String> filteredData = [];

  @override
  void initState() {
    filteredData =
        searchData; // Initialize filtered data with all the data initially.
    super.initState();
  }

  void _filterData(String query) {
    setState(() {
      filteredData = searchData
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text('All Submissions', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 50,
              child: TextField(
                onChanged: _filterData,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  labelText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshList,
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 120,
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: ListTile(
                        title: Text(filteredData[index]),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Office Submitted: ${officeSubmittedData[index]}'),
                            Text('Date: ${dateData[index]}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement the edit functionality here
          print('yeah');

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateSubmissionScreen()),
          );
          // You can navigate to a new edit profile page or show a bottom sheet for editing.
          // For now, we'll show a simple snackbar to indicate that the button is clicked.
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => CreateSubmissionScreen()),
          // );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
