import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fmfdts/screens/SubmissionSuccess.dart';
import 'package:fmfdts/services/CreateSubmissionService.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class CreateSubmissionScreen extends StatefulWidget {
  @override
  _CreateSubmissionScreenState createState() => _CreateSubmissionScreenState();
}

class _CreateSubmissionScreenState extends State<CreateSubmissionScreen> {
  List offices = ['Office A', 'Office B', 'Office C', 'Office D'];
  final List<String> documentTypes = ['Type 1', 'Type 2', 'Type 3', 'Type 4'];
  DateTime selectedDate = DateTime.now();
  late String selectedOffice = 'Office A';
  late String selectedDocumentType = 'Type 1';
  late String documentPath;
  late Box offices_bck;
  late Box user_data;
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController from_addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController submission_formatController = TextEditingController();
  TextEditingController submission_dateController = TextEditingController();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<dynamic> createSubmission() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  user_data = await Hive.openBox('data');

    setState(() {});
    setState(() {
      isLoading = true;
    });

    String url = "https://dtsapi.icreateagency.com/api/vistor-submissions";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + user_data.get('token')
        },
        body: jsonEncode(<String, String>{
          'title': titleController.text,
          'from_address': from_addressController.text,
          'phone': phoneController.text,
          'comments': commentsController.text,
          'submission_format': submission_formatController.text,
          'submission_date': submission_dateController.text,
        }),
      );
      if (response.statusCode == 200) {
        // Successful response
        var _jsonDecode = jsonDecode(response.body);
        print(_jsonDecode);
        await putData(_jsonDecode);

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SubmissionSuccess()),
        );

        // ignore: use_build_context_synchronously
      } else {
        // Backend returned an error

        var errorMessage = jsonDecode(response.body)[
            'errors']; // Modify this based on the actual error field in the response
        print(errorMessage['name']);

        resolveError(error) {
          String name_error = '';
          String email_error = '';
          String password_error = '';

          if (error['name'] != null) {
            name_error = error['name'][0];
          }
          if (error['email'] != null) {
            email_error = error['email'][0];
          }
          if (error['password'] != null) {
            password_error = error['password'][0];
          }

          return name_error + '\n' + email_error + '\n' + password_error;
        }

 

        setState(() {
          isLoading = false;
        });

        // TODO: Handle the error, e.g., show a snackbar or an error dialog.
      }
    } catch (SocketException) {
      setState(() {
        isLoading = false;
      });

      print(SocketException);
    }

    return Future.value(true);
  }

  Future<dynamic> getOffices() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    offices_bck = await Hive.openBox('offices');
    user_data = await Hive.openBox('data');

    String url = "https://dtsapi.icreateagency.com/api/offices";

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

    var mymap2 = offices_bck.toMap().values.toList();

    if (mymap2 == null) {
      offices.add('empty');
    } else {
      offices = mymap2;
      print(offices);
    }

    // return Future.value(true);
  }

  Future putData(data) async {
    await offices_bck.clear();
    for (var d in data) {
      offices_bck.add(d);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getOffices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Create New Submission'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              Container(
                height: 50,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 50,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 50,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'From',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8), // Customize padding

                  labelText: 'Select Office',
                  border: OutlineInputBorder(),
                ),
                value: selectedOffice,
                items: offices.map((office) {
                  return DropdownMenuItem<String>(
                    value: office,
                    child: Text(office),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedOffice = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8), // Customize padding
                  labelText: 'Select Document Type',
                  border: OutlineInputBorder(),
                ),
                value: selectedDocumentType,
                items: documentTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDocumentType = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8), // Customize padding

                    labelText: 'Select Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                  ),
                ),
              ),
              SizedBox(height: 16),
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
                    // TextInput.finishAutofillContext();
                    // print(emailController.text);
                    // print(passwordController.text);

                    // login();

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => DashboardPage()),
                    // );
                  },
                  child: isLoading
                      ? SizedBox(height: 10,
                        child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                      )
                      : const Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

