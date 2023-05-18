
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  void _gitHubSignIn(BuildContext context) async {
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        print(result);
        print(result.token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', result.token.toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Home();
            },
          ),
        );
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
      print("tapped");
        return true;
    },
    child:Scaffold(

      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
    child:  Column(
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

      ))
    )
    );
  }
}