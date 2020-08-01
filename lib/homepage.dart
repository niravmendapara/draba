import 'dart:convert';
import 'package:draba/class/data.dart';
import 'package:draba/widget/header.dart';
import 'package:draba/widget/navbar_icon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'class/data.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Header(),
              Expanded(child: MiddlePart())
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/ic_home.png', width: 20,),
            title: Text('')
          ),
          BottomNavigationBarItem(
//              icon: Image.asset('assets/images/icons8_location_filled.png', width: 20,),
          icon: Icon(Icons.location_on, color: Colors.white,),
              title: Text('')
          ),
          BottomNavigationBarItem(
              icon: Image.asset('assets/ic_added.png', width: 50,),
              title: Text(''),
          ),
          BottomNavigationBarItem(
              icon: Image.asset('assets/ic_heart.png', width: 20,),
              title: Text('')
          ),
          BottomNavigationBarItem(
              icon: Image.asset('assets/ic_user_menu.png',width: 20,),
              title: Text('')
          ),
        ],
      ),
    );
  }
}


class MiddlePart extends StatefulWidget {
  @override
  _MiddlePartState createState() => _MiddlePartState();
}

class _MiddlePartState extends State<MiddlePart> {
  int activeNavBar = 0;
  Future<Album> futureAlbum;
  List<dynamic> dataSet;

  changeTab(int newTab) {
    setState(() {
      this.activeNavBar = newTab;
      futureAlbum = null;
      futureAlbum = fetchAlbum(urlSet[activeNavBar]);
    });
  }

  // Future<http.Response> fetchAlbum() {
  //   return http.get(
  //       'http://167.172.149.230/api/get-hot-events?page=1&limit=10&%20user_id=6');
  // }

  Future<Album> fetchAlbum(String url) async {
    final response = await http.get(
        url);
    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(urlSet[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 28),
      child: Column(
        children: <Widget>[getNavBarRow(), Expanded(
            child: getDataBuilder()
        )],
      ),
    );
  }

  Widget getNavBarRow() {
    return Row(
      children: <Widget>[
        NavBarIcon(
            onclick: () {
              changeTab(0);
            },
            navIcon: Icons.whatshot,
            text: 'Hot',
            isActive: activeNavBar == 0,
            activeCorner: 0),
        NavBarIcon(
            onclick: () {
              changeTab(1);
            },
            navIcon: Icons.list,
            text: 'New',
            isActive: activeNavBar == 1),
        NavBarIcon(
            onclick: () {
              changeTab(2);
            },
            navIcon: Icons.event,
            text: 'Event',
            isActive: activeNavBar == 2),
        NavBarIcon(
            onclick: () {
              changeTab(3);
            },
            navIcon: Icons.star,
            text: 'Special',
            isActive: activeNavBar == 3,
            activeCorner: 1),
      ],
    );
  }

  Widget getUserProfilePic(data) {
     if (data['profile_pic'] != null) {
       return Container(
         width: 30,
         child: Image.network(data['category_image']),
       );
     } else {
       return Container(
         child: Image.asset('assets/ic_user_menu.png'),
       );
     }
  }

  Widget getList() {
    return ListView.builder(
      itemCount: dataSet.length,
      itemBuilder: (context, i) {
        if (dataSet[i] == null) {
          print('NULL');
          return null;
        }
        return Container(
            height: 120,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      dataSet[i]['images'][0],
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // to reduce image contrast
                  Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.black12.withOpacity(0.5),
                  ),
                  // user detail section
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              'assets/ic_coffee_bean.png',
                              width: 8,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              dataSet[i]['favorites'].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          getUserProfilePic(dataSet[i]),
                          SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  dataSet[i]['title'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  dataSet[i]['description'].toString(),
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 12),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  Widget getDataBuilder() {
    return FutureBuilder(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
//          print('DATA');
//          print(snapshot.data.data.length);
          dataSet = snapshot.data.data;

          if(!(dataSet is List)){
            dataSet = snapshot.data.data.data;
          }
          if(dataSet == null){
            return Center(child: CircularProgressIndicator(),);
          }
          return getList();
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}', style: TextStyle(color: Colors.redAccent),);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
