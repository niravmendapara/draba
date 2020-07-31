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
              MiddlePart()
            ],
          ),
        ),
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

  changeTab(int newTab) {
    setState(() {
      this.activeNavBar = newTab;
    });
  }

  // Future<http.Response> fetchAlbum() {
  //   return http.get(
  //       'http://167.172.149.230/api/get-hot-events?page=1&limit=10&%20user_id=6');
  // }

  Future<Album> fetchAlbum() async {
    final response = await http.get(
        'http://167.172.149.230/api/get-hot-events?page=1&limit=10&%20user_id=6');
    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 28),
      child: Column(
        children: <Widget>[getNavBarRow(), getDataBuilder()],
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
            activeCorner: 1)
      ],
    );
  }

  // Widget getList() {
  //   return ListView.builder(
  //       itemCount: 5,
  //       itemBuilder: (context, i) {
  //         return Container(
  //           margin: EdgeInsets.symmetric(vertical: 8),

  //         );
  //       });
  // }

  Widget getDataBuilder() {
    return FutureBuilder(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot);
          return Text(
            '${snapshot.data}',
            style: TextStyle(color: Colors.white),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
