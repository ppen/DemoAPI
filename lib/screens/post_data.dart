import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PostData extends StatefulWidget {
  @override
  _PostDataState createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String titlestring, bodyString;
  Map<String, dynamic> map;
  String showTitle = '';

  // Method
  Widget titleText() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title :'),
      onSaved: (String value) {
        titlestring = value.trim();
      },
    );
  }

  Widget bodyText() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Body :'),
      onSaved: (String value) {
        bodyString = value.trim();
      },
    );
  }

  Widget postButton() {
    return Container(
      width: 200.0,
      child: RaisedButton(
        child: Text('Post data'),
        onPressed: () {
          formKey.currentState.save();
          print('title = $titlestring, body = $bodyString');
          postDataAPI();
        },
      ),
    );
  }

  Future<void> postDataAPI() async {
    String urlString = 'https://jsonplaceholder.typicode.com/posts';
    Map<String, String> headers = {"Content-Type": "application/json"};
    String rawString =
        '{"title":"$titlestring", "body": "$bodyString", "userId": 1}';

    Response response =
        await post(urlString, headers: headers, body: rawString);
    int statusCode = response.statusCode;
    print('statusCode = $statusCode');
    print('response.body = ${response.body}');

    var result = response.body;

    map = jsonDecode(result);
    setState(() {
     showTitle = map['title']; 
    });
  }

  Widget fillText() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Container(
          width: 200.0,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                titleText(),
                bodyText(),
                SizedBox(
                  height: 10.0,
                ),
                postButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showText() {
    return Column(
      children: <Widget>[
        Text('title123 = $showTitle'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        fillText(),
        showText(),
      ],
    );
  }
}
