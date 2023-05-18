import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_clonee_app/provider/repofile_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/branch_provider.dart';

class Repo_view extends StatefulWidget {
  Repo_view({Key? key, required this.repo_name}) : super(key: key);
  final String repo_name;

  @override
  State<Repo_view> createState() => _Repo_viewState(repo_name);
}

class _Repo_viewState extends State<Repo_view> {
  _Repo_viewState(this.repo_name);

  final String repo_name;

  int c_tab=0;
  //int index_clr = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => Provider.of<BranchProvider>(context,listen:false).get_branch_by_repo(repo_name));
    Future.microtask(() => Provider.of<RepoFileProvider>(context,listen:false).fetchrepofile(
        repo_name,
        '',
        ''));
  }



  @override
  Widget build(BuildContext context) {
    final branch_provider=Provider.of<BranchProvider>(context);
    final repofile_provider=Provider.of<RepoFileProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(repo_name),
          backgroundColor: Colors.cyan[900],
        ),
        body: SingleChildScrollView(
            child: DefaultTabController(
                length: branch_provider.branch.length, // length of tabs
                initialIndex: 0,
                child: Column(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.06,
                        child: TabBar(
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                                color: Color(0xFFFF12B6), width: 2.0),
                          ),
                          onTap: (int index) {
                            print(index);
                            setState(() {
                              c_tab=index;
                            });
                              repofile_provider.fetchrepofile(repo_name,branch_provider.branch[index],'');
                          },
                          tabs: [
                            for (var item in branch_provider.branch)
                            Tab(
                                child: Text(item,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: size.height * 0.8,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 0.5))),
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                for(var i=0;i<=branch_provider.branch.length;i++)
                                Container(
                                  child: ListView.builder(
                                    itemCount: repofile_provider.repofile.length,
                                    itemBuilder: (context, index) {

                                      return GestureDetector(
                                        onTap: (){
                                          print('tapped');
                                         if(repofile_provider.repofile[index].type == 'dir'){
                                           print('tapped1');
                                           setState(() {
                                             repofile_provider.fetchrepofile(repo_name,
                                                 branch_provider.branch[c_tab],repofile_provider.repofile[index].path);
                                           });
                                         }
                                        },
                                       child: ListTile(
                                        leading: Icon(repofile_provider.repofile[index].type == 'dir' ? Icons.folder : Icons.file_present),
                                        title: Text(repofile_provider.repofile[index].name),
                                      )
                                      );
                                    },
                                  ),
                                ),
                              ]
                          )
                      ),
                    ]
                )
            )
        )
    );
  }
}
