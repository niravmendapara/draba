import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:draba/homepage.dart';
void main(
  
) => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.blueAccent,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // ignore: non_constant_identifier_names
  @override
  // ignore: must_call_super
  void initState()
  {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogInScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image(image: AssetImage("assets/temp_splash.png"),fit: BoxFit.fill,height: 616,width: 500,),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 300),
                        Center(
                            child: Column(
                              children: <Widget>[
                                Image(image: AssetImage("assets/ic_drabadpre.png"),fit: BoxFit.cover,height: 100,width: 50,),
                                Text("DABARA",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                )),
                              ],
                            ),
                        )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<Login> createAlbum(String email, String password) async {
  final http.Response response = await http.post(
    'http://167.172.149.230/api/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{ 
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    return Login.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Login {
  final String email;
  final String password;

  Login({this.email, this.password});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      email: json['email'],
      password: json['password'],
    );
  }
}

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _obscureText = true;
  Future<Login> _futureLogin;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
        body: Container(
              child: Stack(
                children: <Widget>[
                  Image(image: AssetImage("assets/temp_splash.png"),fit: BoxFit.fill,height: 616,width: 500,),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5),
                        Image(image: AssetImage("assets/ic_drabadpre.png"),fit: BoxFit.cover,height: 100,width: 50,),
                        Text("DABARA",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          )
                        ),
                        Text("Please Login to continue",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 15,
                          )
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 60,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white30,
                          ),
                          
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 5,right: 5),
                                child: Image(image: AssetImage("assets/ic_email.png"),fit: BoxFit.fill,height: 20,width: 25,),
                              ),
                              
                              SizedBox(width: 5,),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(labelText: "Email",labelStyle: TextStyle(color: Colors.white),),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                              ),
                            ],
                          ),
                          
                        ),
                        SizedBox(height: 5,),
                        Container(
                          height: 60,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white30,
                          ),
                          
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 5,right: 5),
                                child: Image(image: AssetImage("assets/ic_lock.png"),fit: BoxFit.fill,height: 25,width: 25,),
                              ),
                              
                              SizedBox(width: 5,),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(labelText: "Password",labelStyle: TextStyle(color: Colors.white),),
                                    keyboardType: TextInputType.text,
                                    obscureText: _obscureText,
                                  ),
                              ),
                              IconButton(icon: Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                      if(_obscureText == true){
                                        _obscureText = false;
                                      }
                                      else{
                                        _obscureText = true;
                                      }
                                    });
                                }
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text("Forgot password ?",style: TextStyle(
                              color: Colors.white,fontSize: 15,
                            ),
                          ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green[400],
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Home();
                          }));
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(flex: 1, child: Text("Sign In",style: TextStyle(fontSize: 20,color: Colors.black),)),
                                Expanded(flex: -1, child: Icon(Icons.arrow_forward,color: Colors.black))
                              ],
                            )
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Text("OR",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),
                        ),

                        SizedBox(height:10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(onPressed: () {
                              print("Doesn't working right now");
                            }, 
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white30,
                              ),
                              child: Image(image: AssetImage("assets/ic_facebook.png"),fit: BoxFit.contain),
                            ),
                            ),
                            
                            FlatButton(
                              onPressed: () {
                                print("Doesn't working right now");
                              }, 
                              child: Container(
                                height: 50,
                                width: 50,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white30,
                                ),
                                child: Image(image: AssetImage("assets/ic_white_google.png"),fit: BoxFit.contain),
                              ),
                            ),
                            
                            FlatButton(
                              onPressed: () {
                                print("Doesn't working right now");
                              }, 
                              child: Container(
                                height: 50,
                                width: 50,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white30,
                                ),
                                child: Image(image: AssetImage("assets/ic_instagram.png"),fit: BoxFit.contain),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't have an Account ?",style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),),
                            Text("Sign Up",style: TextStyle(
                              color: Colors.green[400],
                              fontSize: 20,
                            ),)
                          ],
                        )

                      ],
                    ),
                  )
                ],
              )
        )
      ),
    );
  }
}