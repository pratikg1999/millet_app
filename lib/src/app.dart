import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:millet_app/src/constants.dart';
import 'package:millet_app/src/results.dart';
import 'uploadPhoto.dart';

class App extends StatefulWidget {
  AppState createState() => AppState();
}

class AppState extends State<App> {
  File _image;
  String message = "nothing";
  final serverIpController = TextEditingController(text: serverIP);

  /// [TextEditingController] for password field
  final serverPortController = TextEditingController(text: serverPort);
  final formkey = GlobalKey<FormState>();

  void dialog(BuildContext tempContext, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              AlertDialog(
                //decoration: BoxDecoration(color: Color.fromRGBO(30, 30, 30, 1)),
                content: Center(
                  child: Center(
                    child: Text(
                      message,
                    ),
                  ),
                ),
              ),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Millet disease detection"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: serverIpController,
                      onSaved: (val) => serverIP = val,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "IP is necessary";
                        }
                      },
                      decoration: new InputDecoration(
                        labelText: "Server IP",
                        hintText: "192.168.xx.xx",
                        // errorText: "Invalid IP",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: serverPortController,
                      onSaved: (val) => serverPort = val,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Port is necessary";
                        }
                      },
                      decoration: new InputDecoration(
                        labelText: "Server Port",
                        hintText: "8000",
                        // errorText: "Port is not valid",
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(
                          new FocusNode()); //to hide the on screen keyboard
                      // _submit();
                      formkey.currentState.save();
                      Fluttertoast.showToast(
                        msg:
                            'Successfully updated address to $serverIP:$serverPort',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                      );
                    },
                    child: new Text("Update address"),
                    color: Colors.primaries[3],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    _image = await getImageFromCamera();
                    if (_image != null) {
                      setState(() {});
                    print("uploading");
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                AlertDialog(
                                  //decoration: BoxDecoration(color: Color.fromRGBO(30, 30, 30, 1)),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CircularProgressIndicator(),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "Checking for disease",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]));
                        });
//
                    var response = await uploadFile(_image.path);
                    Navigator.pop(context);
                    print("uploaded");
                    if (response != null &&
                        (response.statusCode == 200 ||
                            response.statusCode == 201)) {
                      message = await response.stream.bytesToString();
                      setState(() {});
                      print(response);
                      print(message);
                      Map messageMap = json.decode(message);
                      if (messageMap["isPlant"] == false) {
                        dialog(context, "No millet identified in image!");
                      } else {
                        if (messageMap["prob"] < 0.35) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        AlertDialog(
                                          //decoration: BoxDecoration(color: Color.fromRGBO(30, 30, 30, 1)),
                                          content: Center(
                                            child: Center(
                                              child: Text(
                                                "Sorry unable to determine with proper accuracy",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                );
                              });
                        } else {
                          if (messageMap["result"] == true ||
                              messageMap["result"] == "True" ||
                              messageMap["result"] == "true") {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          AlertDialog(
                                            //decoration: BoxDecoration(color: Color.fromRGBO(30, 30, 30, 1)),
                                            content: Center(
                                              child: Center(
                                                child: Text(
                                                  "Your millet is healthy",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  );
                                });
//
                          } else {
                            // messageMap["disease"] = "smut";

                            Map<String, String> abtDisease =
                                diseases[messageMap["disease"]];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Result(
                                    prob: messageMap["prob"],
                                    diseaseName: messageMap["disease"],
                                    content: abtDisease,
                                  ),
                                ));
                          }
                        }
                      }
                    }
                    }
                  },
                  child: Text("Capture image"),
                ),
                RaisedButton(
                  onPressed: () async {
                    _image = await getImageFromGallery();
                    if (_image != null) {
                      setState(() {});
                      print("uploading");
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                  AlertDialog(
                                    //decoration: BoxDecoration(color: Color.fromRGBO(30, 30, 30, 1)),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        CircularProgressIndicator(),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              "Checking for disease",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]));
                          });
//
                      var response = await uploadFile(_image.path);
                      Navigator.pop(context);
                      print("uploaded");
                      print(response);
                      if (response != null &&
                          (response.statusCode == 200 ||
                              response.statusCode == 201)) {
                        message = await response.stream.bytesToString();
                        setState(() {});
                        print(message);
                        Map messageMap = json.decode(message);
                        if (messageMap["isPlant"] == false) {
                          dialog(context, "No millet identified in image!");
                        } else {
                          if (messageMap["prob"] < 0.4) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          AlertDialog(
                                            //decoration: BoxDecoration(color: Color.fromRGBO(30, 30, 30, 1)),
                                            content: Center(
                                              child: Center(
                                                child: Text(
                                                  "Sorry unable to determine with proper accuracy",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  );
                                });
                          } else {
                            if (messageMap["result"] == true ||
                                messageMap["result"] == "True" ||
                                messageMap["result"] == "true") {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            AlertDialog(
                                              //decoration: BoxDecoration(color: Color.fromRGBO(30, 30, 30, 1)),
                                              content: Center(
                                                child: Center(
                                                  child: Text(
                                                    "Your millet is healthy",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                    );
                                  });
                            } else {
                              // messageMap["disease"] = "smut";

                              Map<String, String> abtDisease =
                                  diseases[messageMap["disease"]];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Result(
                                      prob: messageMap["prob"],
                                      diseaseName: messageMap["disease"],
                                      content: abtDisease,
                                    ),
                                  ));
                            }
                          }
                        }
                      }
                    }
                  },
                  child: Text("Choose image"),
                ),
              ],
            ),
            Image(
              image: _image != null
                  ? FileImage(_image)
                  : AssetImage("assets/images/millet_watermark.jpg"),
              color: _image == null
                  ? Color.fromARGB(100, 0, 0, 0)
                  : Color.fromARGB(255, 0, 0, 0),
              colorBlendMode: BlendMode.dstIn,
            ),
            Text(
              message,
              overflow: TextOverflow.visible,
            ),
            // RaisedButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => Result(
            //             diseaseName: "Title",
            //             content: {"1": "pratik", "seconf": "pranay"},
            //           ),
            //         ));
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Future<File> getImageFromGallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<File> getImageFromCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    return image;
  }
}
