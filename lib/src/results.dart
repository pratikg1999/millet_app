// import 'dart:io';

import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final String diseaseName;
  final double prob;
  final Map<String, String> content;
  Result({String diseaseName, double prob, Map<String, String> content}) : this.prob = prob, this.diseaseName = diseaseName, this.content = content;
  @override
  ResultState createState() {
    return ResultState();
  }
}

class ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About " + widget.diseaseName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[Card(
                      elevation: 5.0,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Probablity",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // color: Colors.blue,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Text((widget.prob*100).toStringAsFixed(2)+"%"),
                        ],
                      ),
                    ),]+[
            for (MapEntry<String, String> entry in widget.content.entries)
              Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      elevation: 5.0,
                      child: Column(
                        children: <Widget>[
                          Text(
                            entry.key,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // color: Colors.blue,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(entry.value)
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
