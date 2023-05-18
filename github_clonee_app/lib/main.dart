
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:github_clonee_app/provider/branch_provider.dart';
import 'package:github_clonee_app/provider/org_provider.dart';
import 'package:github_clonee_app/provider/repo_provider.dart';
import 'package:github_clonee_app/provider/repofile_provider.dart';
import 'package:github_clonee_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:github_clonee_app/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OrgProvider()),
        ChangeNotifierProvider(create: (_) => RepoProvider()),
        ChangeNotifierProvider(create: (_) => BranchProvider()),
        ChangeNotifierProvider(create: (_) => RepoFileProvider()),
      ],
      child: MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor:  Colors.grey[300],),
        home: Home(),
      )),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        home: Home(),
      );
  }
}



