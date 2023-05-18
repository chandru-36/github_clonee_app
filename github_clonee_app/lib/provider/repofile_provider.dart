import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../classes/repofile_class.dart';



class RepoFileProvider extends ChangeNotifier {
  List<Repofile_Class> _repofile = [];

  List<Repofile_Class> get repofile => _repofile;


  Future<void> fetchrepofile(String reponame,String branch,String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token=prefs.getString('access_token');
    var owner=prefs.getString('login');
    String url='';
    if(path=="" && branch==''){
       url = 'https://api.github.com/repos/'+owner!+'/'+reponame+'/contents/';
    }else{
      if(path==""){
        url = 'https://api.github.com/repos/'+owner!+'/'+reponame+'/contents/?ref=' + branch;
      }else {
        url = 'https://api.github.com/repos/'+owner!+'/'+reponame+'/contents/' + path +
            '/?ref=' + branch;
      }

    }


    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/vnd.github+json',
      'Authorization': 'Bearer $token',
      'X-GitHub-Api-Version': '2022-11-28'
    });

    if(response.statusCode ==200){

      var jsonData = jsonDecode(response.body);

      repofile.clear();
      for (var u in jsonData) {
        Repofile_Class cat = Repofile_Class(
          name:  u['name'] ?? 'unknown',
          path:  u['path'] ?? 'unknown',
          type: u['type']?? 'unknown',
        );
        _repofile.add(cat);
      }
    }else if(response.statusCode ==401){
      prefs.clear();
    }
    notifyListeners();
  }

}