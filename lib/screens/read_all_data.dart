import 'package:demoapi/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReadAllData extends StatefulWidget {
  @override
  _ReadAllDataState createState() => _ReadAllDataState();
}

class _ReadAllDataState extends State<ReadAllData> {
  // Explcit
  String urlString = 'https://jsonplaceholder.typicode.com/photos';
  List<ImageModel> imageModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    var response = await http.get(urlString);
    //print('response = ${response.toString()}');

    var result = json.decode(response.body);
    //print('result = $result');

    for (var myMap in result) {
      ImageModel imageModel = ImageModel.FromJSON(myMap);
      //String urlPath = ImageModel.FromJSON();
      //print('url = $urlPath');
      //int id = imageModel.id;
      // String title = imageModel.title;
      //print('id =$id');

      setState(() {
        imageModels.add(imageModel);
      });
    }
  }

  Widget showText(int index) {
    return Container(
      //color: Colors.green,
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'id = ${imageModels[index].id}',
            style: TextStyle(fontSize: 30.0),
          ),
          Text(imageModels[index].title),
        ],
      ),
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(imageModels[index].url),
    );
  }

  // Widget pleaseWait() {
  //   return Center(
  //     child: Text('Plesae wait'),
  //   );
  // }
  Widget pleaseWait() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showListView() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[
            showImage(index),
            showText(index),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: imageModels.length != 0 ? showListView() : pleaseWait(),
    );
  }
}
