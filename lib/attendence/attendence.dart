import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// Check if the user is logged in

class Attendance {
  static const String url =
      "https://script.google.com/macros/s/AKfycbz5Q7-jOI6g3n7X8ZXZpq4m5bm3A5uzgDAiTHTv3s0LR2eV4-E0DavMLRkHsTwD_wgi/exec";
  static const STATUS_SUCCESS = "SUCCESS";

  void submitFormcheckIn(String name, String email, String date, String time,
      void Function(String) callback) async {
    try {
      await http.post(Uri.parse(url), body: {
        'name': name,
        'email': email,
        'date': date,
        'checkIn': time,
        'checkOut': ""
      }).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void submitFormcheckOut(String name, String email, String date, String time,
      void Function(String) callback) async {
    try {
      await http.post(Uri.parse(url), body: {
        'name': name,
        'email': email,
        'date': date,
        'checkOut': time,
        'checkIn': ""
      }).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
