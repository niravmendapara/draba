import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset('assets/ic_filter.png',width: 31,),
        Image.asset('assets/ic_label.png',width: 40,),
        Image.asset('assets/ic_search_location.png',width: 25,)
      ],
    );
  }
}
