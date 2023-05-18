
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool load=false;
  final GitHubSignIn gitHubSignIn = GitHubSignIn(
    clientId: 'Iv1.fca09cd42a8ce389',
    clientSecret: '31130e4a5c47367f5fbc1057309fff0e689eec89',
    redirectUrl: 'https://test-6ab58.firebaseapp.com/__/auth/handler',
    scope: "user,gist,user:email,admin:org,read:org,repo,admin:enterprise, admin:gpg_key, admin:org, admin:org_hook, admin:public_key, admin:repo_hook, admin:ssh_signing_key, audit_log, codespace, delete:packages, delete_repo, gist, notifications, project, repo, user, workflow, write:discussion, write:packages",

  );

  @override
  void initState() {
    super.initState();
  }

  set_owner_name(String? token) async {
    String url = 'https://api.github.com/user';
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/vnd.github+json',
      'Authorization': 'Bearer $token',
      'X-GitHub-Api-Version': '2022-11-28'
    });
    if(response.statusCode ==200){
      var jsonData = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', token!);
      prefs.setString('login', jsonData['login']);
      setState(() {
        load=false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Home();
            },
          ),
        );
      });
    }
  }

  void _gitHubSignIn(BuildContext context) async {
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        setState(() {
          load=true;
        });
        set_owner_name(result.token);
        break;

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        print(result.errorMessage);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
        return true;
    },
    child:Scaffold(

      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
    child:  load==false?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: size.width*1,
              padding: EdgeInsets.only(bottom: 50),
              child:Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/images.png"
                )
              )
          ),
          Container(
            width: size.width*1,
            padding: EdgeInsets.only(bottom: 10),
            child:Align(
              alignment: Alignment.center,
            child: Text(
              "To authenticate with the Git hub tap the below button"
            ),
            )
          ),
          Container(
            height: 60,
            width: size.width*1,

            child: Center(
              child:GestureDetector(
                onTap: (){
                  _gitHubSignIn(context);
                },
             child: Container(
                height: 60,
                width: size.width*0.6,
                color: Colors.pink,
              child: Align(
                alignment: Alignment.center,
             child:
              Text(
                "Github Login",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize:20
                ),
              ),
              )
              )
              )
            ),
          )
        ],

      ):Container(
        height: size.height * 1,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 15,
              ),
            ],
          ),)
    ),
      )

    )
    );
  }
}
