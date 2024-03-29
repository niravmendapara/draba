import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:draba/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Size displaySize(BuildContext context) {
  debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                  Image(image: AssetImage("assets/temp_splash.png"),fit: BoxFit.cover,height: 616,width: 640,),
                  Column(
                    children: <Widget>[
                      SizedBox(height: displayHeight(context)*0.5),
                        Center(
                            child: Column(
                              children: <Widget>[
                                Image(image: AssetImage("assets/ic_drabadpre.png"),fit: BoxFit.cover,height: 100,width: 50,),
                                Text("DRABA",style: TextStyle(
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



class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _obscureText = true;
  // ignore: unused_field
  bool _isLoading = false;
  //bool _isLoading = false;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
        body: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: <Widget>[
                    Image(image: AssetImage("assets/temp_splash.png"),fit: BoxFit.cover,height: 640,width: 640),
                    Container(
                      padding: EdgeInsets.all(displayWidth(context)*0.04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5),
                          Image(image: AssetImage("assets/ic_drabadpre.png"),fit: BoxFit.cover,height: displayHeight(context)*0.2,width: 50,),
                          Text("DRABA",
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
                            height: 50,
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
                                    controller: emailController,
                                    decoration: InputDecoration(hintText: "Email",hintStyle: TextStyle(color: Colors.white),),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            height: 50,
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
                                    controller: passwordController,
                                    decoration: InputDecoration(hintText: "Password",hintStyle: TextStyle(color: Colors.white),),
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
                                setState(() {
                                  _isLoading = true;
                                });
                                signIn(emailController.text, passwordController.text);
                                /*Navigator.push(context, MaterialPageRoute(builder: (context){
                              return Home();
                            }));*/
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
                          SizedBox(height: displayHeight(context)*0.1),
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
                ),
              )
        )
      ),
    );
  }
  signIn(String email, String password) async {
    Map data = {
      'email': email,
      'password': password
    };
    var jsonData;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post('http://167.172.149.230/api/login',body: data);
    print(data);
    jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        _isLoading = false;
        sharedPreferences.setString("token", jsonData["token"]);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home()), (Route<dynamic> route) => false);
      });
    }
    else {
      print(response.body);
    }
  }
}