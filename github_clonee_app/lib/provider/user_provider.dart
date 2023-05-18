import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/user_class.dart';


class UserProvider extends ChangeNotifier {
List<User_Class> _users = [];

List<User_Class> get users => _users;



Future<void> fetchusers() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token=prefs.getString('access_token');
  String url = 'https://api.github.com/user';
  final response = await http.get(Uri.parse(url), headers: {
    'Accept': 'application/vnd.github+json',
    'Authorization': 'Bearer $token',
    'X-GitHub-Api-Version': '2022-11-28'
  });

  if(response.statusCode ==200){

    users.clear();
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    User_Class cat = User_Class(
        user_name: jsonData['login']??'',
        full_name: jsonData['name']??'',
        company: jsonData['company']??'unknown',
        location: jsonData['location']??'unknown',
        email: jsonData['email']??'unknown',
        avatar: jsonData['avatar_url']??'unknown',
    );
    prefs.setString('login', jsonData['login']);
    _users.add(cat);
  }else if(response.statusCode ==401){
    prefs.clear();
  }

  notifyListeners();
}
}