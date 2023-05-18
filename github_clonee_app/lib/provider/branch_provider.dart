import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class BranchProvider extends ChangeNotifier {
  List<String> _branch = [];

  List<String> get branch => _branch;


  Future<void> get_branch_by_repo(String repo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token=prefs.getString('access_token');
    var owner=prefs.getString('login');
    String url = 'https://api.github.com/repos/'+owner!+'/'+repo!+'/branches';


    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/vnd.github+json',
      'Authorization': 'Bearer $token',
      'X-GitHub-Api-Version': '2022-11-28'
    });
    if(response.statusCode ==200){
      var jsonData = jsonDecode(response.body);
      branch.clear();
      _branch.clear();
      for (var u in jsonData) {
        _branch.add(u['name']);
      }


    }else if(response.statusCode ==401){
      prefs.clear();
    }
    notifyListeners();
  }

}