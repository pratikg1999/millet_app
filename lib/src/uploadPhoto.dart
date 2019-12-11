// import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
import 'constants.dart';
import 'package:http_parser/http_parser.dart';

Future<http.StreamedResponse> uploadFile(String filePath) async {
  // http.get("https://www.google.com").then((response) {
  //   if (response.statusCode == 200) {
  //     Fluttertoast.showToast(
  //       msg: 'Successfully googled',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIos: 1,
  //     );
  //   }
  // });
  var uri = new Uri.http('$serverIP:$serverPort', '/webapp/file');
//  Fluttertoast.showToast(
//         msg: '$serverIP:$serverPort/webapp/file',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//       );
  final String photoDir = '$filePath';

  var request = new http.MultipartRequest("POST", uri);

  request.files.add(await http.MultipartFile.fromPath('file', photoDir,
      contentType: MediaType('image', 'png')));
  http.StreamedResponse response;
  try {
  print("under try block");
  response = await request.send().timeout(const Duration(seconds: 25)); 
  // request.send().then((response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: 'Successfully uploaded',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );
    } else {
      print("failded wrong status code received");
      Fluttertoast.showToast(
        msg: 'image failed to upload..',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );
      // String currentTime =  DateTime.now().millisecondsSinceEpoch.toString();
      // String newPath = photoDir.substring(0, photoDir.lastIndexOf("/")) + "/" + currentTime + "NotUploaded.mp4";
      //   File(filePath).renameSync(newPath);
    }
  // });
  } catch (e) {
    print("failded to upload");
    Fluttertoast.showToast(
        msg: 'image failed to upload..',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
      );
  }
  return response;
}
