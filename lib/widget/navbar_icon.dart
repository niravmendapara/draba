import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavBarIcon extends StatelessWidget {
  NavBarIcon({
    @required this.onclick,
    this.navIcon,
    this.text,
    this.isActive = false,
    this.activeCorner = -1,
  });

  bool isActive;
  final IconData navIcon;
  String text;
  int activeCorner;
  final GestureTapCallback onclick;

  @override
  Widget build(BuildContext context) {
    Color assetColor = Colors.white;
    Color bgColor = Color(0xff555555);
    if (isActive) {
      assetColor = Colors.black;
      bgColor = Colors.greenAccent;
    }
    return Expanded(
      child: GestureDetector(
        onTap: onclick,
        child: Container(
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: activeCorner == 0
                  ? BorderRadius.horizontal(left: Radius.circular(8))
                  : activeCorner == 1
                      ? BorderRadius.horizontal(right: Radius.circular(8))
                      : null),
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                navIcon,
                color: assetColor,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                text,
                style: TextStyle(color: assetColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
