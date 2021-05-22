import 'package:flutter/material.dart';

Widget bottonBarNavegador(BuildContext context) {
  return Theme(
      data: Theme.of(context).copyWith(),
      child: BottomNavigationBar(
        // backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        // selectedItemColor: Colors.pink,
        // unselectedItemColor: Color.fromRGBO(166, 117, 152, 1.0),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 30.0), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 30.0), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.supervised_user_circle,
                size: 30.0,
              ),
              label: ''),
        ],
      ));
}
