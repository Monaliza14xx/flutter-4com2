import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/student.dart';
import '../button/custom_button.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Student> data = [];

  void mapData(List<dynamic> value) {
    setState(() {
      data = value.map((json) => Student.fromJson(json)).toList();
    });
  }

  void getData() async {
    var url = Uri.parse('https://sheetdb.io/api/v1/4q5fhwwuonqmj');
    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      mapData(jsonDecode(utf8.decode(res.bodyBytes)));
      print(data);
    } else {
      print('Failed to fetch data');
    }
  }

  int getNextId() {
    if (data.isEmpty) {
      return 1; // Start with ID 1 if data is empty
    }
    int highestId = data.map((student) => int.parse(student.id)).reduce((a, b) => a > b ? a : b);
    return highestId + 1;
  }

  Future<void> sendDataToServer(Student student) async {
    var url = Uri.parse('https://sheetdb.io/api/v1/4q5fhwwuonqmj');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'id': student.id,
        'std_id': student.stdId,
        'name': student.name,
        'surname': student.surname,
      }),
    );

    if (response.statusCode == 201) {
      print('Data sent to server successfully');
    } else {
      print('Failed to send data to server');
    }
  }

  Future<void> updateDataOnServer(Student student) async {
    var url = Uri.parse('https://sheetdb.io/api/v1/4q5fhwwuonqmj/id/${student.id}');
    var response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'std_id': student.stdId,
        'name': student.name,
        'surname': student.surname,
      }),
    );

    if (response.statusCode == 200) {
      print('Data updated successfully on server');
    } else {
      print('Failed to update data on server');
    }
  }

  Future<void> deleteDataFromServer(String id) async {
    var url = Uri.parse('https://sheetdb.io/api/v1/4q5fhwwuonqmj/id/$id');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Data deleted successfully from server');
    } else {
      print('Failed to delete data from server');
    }
  }

  void addData() {
    TextEditingController stdIdController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: stdIdController,
                decoration: InputDecoration(labelText: 'Student ID'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(labelText: 'Surname'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                var newStudent = Student(
                  id: getNextId().toString(),
                  stdId: stdIdController.text,
                  name: nameController.text,
                  surname: surnameController.text,
                );

                setState(() {
                  data.add(newStudent);
                });

                await sendDataToServer(newStudent);

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void editData(Student student) {
    TextEditingController stdIdController = TextEditingController(text: student.stdId);
    TextEditingController nameController = TextEditingController(text: student.name);
    TextEditingController surnameController = TextEditingController(text: student.surname);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: stdIdController,
                decoration: InputDecoration(labelText: 'Student ID'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(labelText: 'Surname'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  student.stdId = stdIdController.text;
                  student.name = nameController.text;
                  student.surname = surnameController.text;
                });

                await updateDataOnServer(student);

                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void confirmDelete(Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${student.name} ${student.surname}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  data.remove(student);
                });

                await deleteDataFromServer(student.id);

                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              btnFunc: getData,
              btnColor: Colors.green,
              btnText: "Fetch Data",
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var item = data[index];
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: Text('${item.name} ${item.surname}'),
                      subtitle: Text('ID: ${item.stdId}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => editData(item),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => confirmDelete(item),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addData,
        tooltip: 'Add Student',
        child: Icon(Icons.add),
      ),
    );
  }
}
