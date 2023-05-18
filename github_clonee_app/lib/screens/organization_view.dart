import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_clonee_app/provider/repo_provider.dart';
import 'package:github_clonee_app/screens/repositories_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/org_provider.dart';

class Organization_view extends StatefulWidget {

   Organization_view({Key? key,required this.org_name,required this.disc}) : super(key: key);
  final String org_name;
   final String disc;

  @override
  State<Organization_view> createState() => _Organization_viewState(org_name,disc);
}

class _Organization_viewState extends State<Organization_view> {
  _Organization_viewState(this.org_name,this.disc);
  final String org_name;
  final String disc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => Provider.of<OrgProvider>(context,listen:false).get_member_count(org_name));
    Future.microtask(() => Provider.of<RepoProvider>(context,listen:false).fetchprepo_by_org(org_name));
   // get_organization_detaiils();
  }


  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    final org_provider=Provider.of<OrgProvider>(context);
    final repo_provider=Provider.of<RepoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            org_name
        ),
        backgroundColor: Colors.cyan[900],
      ),
        body:
        SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(10),
          width: size.width*1,
          child: Column(
            children: [
              Card(
                  child:Container(
                    width: size.width*1,
                    padding: EdgeInsets.only(top: 10,left: 5,bottom: 10,right: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children:  <TextSpan>[
                            TextSpan(text: 'Discription: ',
                                style: TextStyle(
                                  decoration:TextDecoration.none,
                                fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'Roboto'
                            )),
                            TextSpan(
                                text: disc,
                                style: TextStyle(
                                    decoration:TextDecoration.none,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: 'Roboto'
                                )
                            ),
                          ],
                        ),
                      )
                    ),
                  )
              ),
              Container(
                height: size.height*0.2,
                width: size.width*1,
                padding: EdgeInsets.only(left: 10,right: 10),
                child: GridView.count(
                    crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: size.height*0.1,
                    children:[
                      Card(
                          child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  Container(
                                    height: size.height*0.1,
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.group,
                                      color: Colors.pink,
                                      size: 50.0,
                                    ),
                                  ),
                                  Text((org_provider.members).toString()+" Members",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                      )),
                                ]
                            ),
                          )
                      ),
                     Card(
                         // color: Colors.orange,
                          child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: size.height*0.1,
                                    padding: EdgeInsets.all(10),
                                    child:  Icon(
                                      Icons.storage,
                                      color: Colors.pink,
                                      size: 50.0,
                                    ),
                                  ),
                                  Text((repo_provider.r_count).toString()+" Repositories",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                      )),
                                ]
                            ),
                          )
                      ),

                    ]
                ),
              ),
              Container(
                width: size.width*1,
                child: Column(
                  children: [
                    Card(
                        child:Container(
                          height: size.height*0.07,
                          width: size.width*1,
                          padding: EdgeInsets.only(left: 5),
                          // color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Repositories:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  decoration:TextDecoration.none
                              ),
                            ),
                          ),
                        )
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Card(
                        child:
                        repo_provider.repoorg.isNotEmpty?Container(
                            height: size.height*0.17*(repo_provider.repoorg.length/3).ceil(),
                            width: size.width*1,
                            padding: EdgeInsets.only(left: 5,top: 5),
                            // color: Colors.red,
                            child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 3,
                                crossAxisSpacing: size.height*0.008,
                                mainAxisSpacing: size.width*0.016,
                                children: List.generate(repo_provider.repoorg.length, (index) {
                                  return GestureDetector(
                                      onTap: (){

                                      },
                                      child:
                                      Card(
                                          color: Colors.grey,
                                          child: Center(child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height: size.height*0.1,
                                                  padding: EdgeInsets.all(10),
                                                  child:  Icon(
                                                    Icons.storage,
                                                    color: Colors.pink,
                                                    size: 50.0,
                                                  ),
                                                ),
                                            Expanded(child: Text(repo_provider.repoorg[index].name,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600
                                                    )),
                                            )
                                              ]
                                          ),
                                          )
                                      )
                                  );
                                }
                                )
                            )
                        ):Container(
                            height: size.height * 0.17,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
    )
    )
    );
  }
}
