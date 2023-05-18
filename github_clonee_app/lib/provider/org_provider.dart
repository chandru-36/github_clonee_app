import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/org_class.dart';



class OrgProvider extends ChangeNotifier {
  List<Org_Class> _org = [];

  List<Org_Class> get org => _org;

  int _members = 0;

  int get members => _members;




  Future<void> get_member_count(String org) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token=prefs.getString('access_token');
    String url = 'https://api.github.com/orgs/'+org+'/members';
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/vnd.github+json',
      'Authorization': 'Bearer $token',
      'X-GitHub-Api-Version': '2022-11-28'
    });
    if(response.statusCode ==200){

      var jsonData = jsonDecode(response.body);

      _members=jsonData.length;

    }else if(response.statusCode ==401){
      prefs.clear();
    }
    notifyListeners();
  }

  Future<void> fetchorganization() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token=prefs.getString('access_token');
    var owner=prefs.getString('login');

    String url = 'https://api.github.com/users/'+owner!+'/orgs';
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/vnd.github+json',
      'Authorization': 'Bearer $token',
      'X-GitHub-Api-Version': '2022-11-28'
    });

    if(response.statusCode ==200){

      var jsonData = jsonDecode(response.body);

      org.clear();
      for (var u in jsonData) {
        Org_Class cat = Org_Class(
          login: u['login'] ?? '',
          avatar: u['avatar_url'] ?? 'unknown',
          description:u['description'] ?? 'No Discription',
        );
        _org.add(cat);
      }
    }else if(response.statusCode ==401){
      prefs.clear();
    }
    notifyListeners();
  }
}