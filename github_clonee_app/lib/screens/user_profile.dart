
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import '../provider/user_provider.dart';

class Uer_Profile extends StatefulWidget {
  @override
  _Uer_ProfilePageState createState() => _Uer_ProfilePageState();
}

class _Uer_ProfilePageState extends State<Uer_Profile> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user_provider=Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child:
           Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: size.height*0.3,
                          width: size.width*1,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                child: Container(
                                  height: size.height*0.15,
                                  width: size.width*1,
                                  color: Colors.cyan[900],
                                ),
                              ),
                              Center(
                                  child: CircleAvatar(
                                      radius: 85.0,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 80.0,
                                        backgroundImage: NetworkImage(user_provider.users[0].avatar),
                                      )
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Divider(),

                        Text(
                          user_provider.users[0].full_name==''?'${user_provider.users[0].user_name}':'${user_provider.users[0].full_name}',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Icon(
                                Icons.email_outlined,
                                color: Colors.pink,
                                size: 24.0,
                              ),
                              Text(
                                user_provider.users[0].email,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ]
                        ),
                        SizedBox(height: 16.0),
                        Divider(),
                        SizedBox(height: 16.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Icon(
                                Icons.business_outlined,
                                color: Colors.pink,
                                size: 24.0,
                              ),
                              Text(
                                'Company ',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),

                            ]
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '${user_provider.users[0].company}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),


                        SizedBox(height: 16.0),
                        Divider(),
                        SizedBox(height: 16.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.pink,
                                size: 24.0,
                              ),
                              Text(
                                'Location ',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),

                            ]
                        ),

                        SizedBox(height: 8.0),
                        Text(
                          '${user_provider.users[0].location}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.0),
                        Divider(),
                        SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.clear();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Login();
                                  },
                                ),
                              );
                          },
                      child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[

                              Text(
                                'Logout ',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Icon(
                                Icons.logout,
                                color: Colors.pink,
                                size: 24.0,
                              ),
                            ]
                        )
                        ),

                      ],
                    ),



            ),
          ),

    );
  }
}