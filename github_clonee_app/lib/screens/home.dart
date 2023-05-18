
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:github_clonee_app/provider/org_provider.dart';
import 'package:github_clonee_app/provider/repo_provider.dart';
import 'package:github_clonee_app/provider/user_provider.dart';
import 'package:github_clonee_app/screens/organization_view.dart';
import 'package:github_clonee_app/screens/repositories_view.dart';
import 'package:github_clonee_app/screens/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:github_clonee_app/screens/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  void initState() {
    check_token();
    // TODO: implement initState
    Future.microtask(() => Provider.of<UserProvider>(context,listen:false).fetchusers());
    Future.microtask(() => Provider.of<OrgProvider>(context,listen:false).fetchorganization());
    Future.microtask(() => Provider.of<RepoProvider>(context,listen:false).fetchprepo());
    super.initState();
  }

  check_token() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token=prefs.getString('access_token');
    print(token);
    if(token==null){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    final user_provider=Provider.of<UserProvider>(context);
    final org_provider=Provider.of<OrgProvider>(context);
    final repo_provider=Provider.of<RepoProvider>(context);

    return  Scaffold(
      body:
   SafeArea(
    child:SingleChildScrollView(
         child: Container(

           child: Column(
             children: [
               Container(
                 child:
               user_provider.users.isNotEmpty?Container(
                 height: size.height*0.1,
                 color: Colors.cyan[900],
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       padding: EdgeInsets.all(10),
                       width: size.width*0.79,
                       height: size.height*0.1,
                       child:Column(
                       children: [
                         Container(
                           child: Align(
                             alignment: Alignment.centerLeft,
                             child:const Text(
                               " Hello!",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 14,
                                 fontWeight: FontWeight.w500,
                                   decoration:TextDecoration.none
                               ),
                             ),
                           ),
                         ),
                         Container(
                           child: Align(
                             alignment: Alignment.centerLeft,
                             child: Text(
                               user_provider.users[0].full_name==''?user_provider.users[0].user_name:user_provider.users[0].full_name,
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 22,
                                   fontWeight: FontWeight.w500,
                                   decoration:TextDecoration.none
                               ),
                             ),
                           ),
                         )
                       ],
                     ),
                     ),
                     Container(

                       width: size.width*0.15,
                       height: size.height*0.1,
                       padding: EdgeInsets.only(bottom: size.height*0.035,top: 10),
                       child: GestureDetector(
                         onTap: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) {
                                 return Uer_Profile();
                               },
                             ),
                           );
                         },
                         child:
                       CircleAvatar(
                           radius:25,
                         backgroundImage:  NetworkImage(
                           user_provider.users[0].avatar,
                         ),
                       )
                       )
                       //color: Colors.orange,
                     )
                   ],
                 ),
               ):Container(
             height: size.height * 0.15,
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
              Container(
                padding: EdgeInsets.all(10),
                child:Column(
                 children:[

               Container(
                 width: size.width*1,
                 child: Column(
                   children: [
                    Card(
                        child:Container(
                       height: size.height*0.07,
                       width: size.width*1,
                      padding: EdgeInsets.only(left: 5),
                       child: Align(
                         alignment: Alignment.centerLeft,
                         child: Text(
                           "Organizations:",
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
                 org_provider.org.isNotEmpty? Container(
                      height: size.height*0.17*(org_provider.org.length/3).ceil(),
                       width: size.width*1,
                       padding: EdgeInsets.only(left: 5,top: 5),
                       child: GridView.count(
                           physics: NeverScrollableScrollPhysics(),
                           crossAxisCount: 3,

                           crossAxisSpacing: size.height*0.008,
                           mainAxisSpacing: size.width*0.016,
                           children: List.generate(org_provider.org.length, (index) {
                             return GestureDetector(
                               onTap: (){
                                 print("org tapped");
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) {
                                       return Organization_view(org_name: org_provider.org[index].login,disc: org_provider.org[index].description);
                                     },
                                   ),
                                 );
                               },
                             child:
                               Card(
                                   color: Colors.orange,
                                   child:Center(
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: <Widget>[
                                         Container(
                                           height: size.height*0.1,
                                           padding: EdgeInsets.all(10),
                                           child: Image.network(
                                               org_provider.org[index].avatar
                                           ),
                                         ),
                                         Expanded(child:
                                         Text(org_provider.org[index].login,
                                             maxLines: 1,
                                             overflow: TextOverflow.ellipsis,
                                             style: TextStyle(
                                                 fontSize: 16,
                                                 fontWeight: FontWeight.w600,
                                             ))
                                         ),
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
               Container(
                 width: size.width*1,
                 child: Column(
                   children: [
                     Card(
                         child:Container(
                           height: size.height*0.07,
                           width: size.width*1,
                           padding: EdgeInsets.only(left: 5),
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
                         repo_provider.repo.isNotEmpty?Container(
                             height: size.height*0.17*(repo_provider.repo.length/3).ceil(),
                             width: size.width*1,
                             padding: EdgeInsets.only(left: 5,top: 5),
                             child: GridView.count(
                               physics: NeverScrollableScrollPhysics(),
                                 crossAxisCount: 3,
                                 crossAxisSpacing: size.height*0.008,
                                 mainAxisSpacing: size.width*0.016,
                                 children: List.generate(repo_provider.repo.length, (index) {
                                   return GestureDetector(
                                       onTap: (){
                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) {
                                               return Repo_view(repo_name: repo_provider.repo[index].name);
                                             },
                                           ),
                                         );
                                   },
                                   child:
                                   Card(
                                       color: Colors.orange,
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
                                         Expanded(child: Text(repo_provider.repo[index].name,
                                                 maxLines: 2,
                                                 overflow: TextOverflow.ellipsis,
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
               )
                   ]
                )
              )

             ],
           ),
         ),

    )
   )
    );
  }
}
