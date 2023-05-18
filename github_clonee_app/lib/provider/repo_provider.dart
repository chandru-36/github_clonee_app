import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/repo_class.dart';



class RepoProvider extends ChangeNotifier {
  List<Repo_Class> _repo = [];

  List<Repo_Class> _repoorg = [];

  List<Repo_Class> get repo => _repo;

  List<Repo_Class> get repoorg => _repoorg;

  int _r_count = 0;

  int get r_count => _r_count;


  Future<void> fetchprepo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token=prefs.getString('access_token');
    var owner=prefs.getString('login');
    String url =  'https://api.github.com/users/'+owner!+'/repos';
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/vnd.github+json',
      'Authorization': 'Bearer $token',
      'X-GitHub-Api-Version': '2022-11-28'
    });

    if(response.statusCode ==200){

      var jsonData = jsonDecode(response.body);

      repo.clear();
      for (var u in jsonData) {
        Repo_Class cat = Repo_Class(
          name:  u['name'] ?? 'unknown',
          full_name:  u['full_name'] ?? 'unknown',
          description:  u['description'] ?? 'unknown',
        );
        _repo.add(cat);
      }
    }else if(response.statusCode ==401){
      prefs.clear();
    }
    notifyListeners();
  }

  Future<void> fetchprepo_by_org(org) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token=prefs.getString('access_token');
    String url =  'https://api.github.com/orgs/'+org+'/repos';
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/vnd.github+json',
      'Authorization': 'Bearer $token',
      'X-GitHub-Api-Version': '2022-11-28'
    });

    if(response.statusCode ==200){
      print("fetchprovider");
      print(response);
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      _r_count=jsonData.length;
      repoorg.clear();
      for (var u in jsonData) {
        Repo_Class cat = Repo_Class(
          name:  u['name'] ?? 'unknown',
          full_name:  u['full_name'] ?? 'unknown',
          description:  u['description'] ?? 'unknown',
        );
        repoorg.add(cat);
      }
    }else if(response.statusCode ==401){
      prefs.clear();
    }
    notifyListeners();
  }
}