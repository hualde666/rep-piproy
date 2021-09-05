import 'package:flutter/material.dart';

class BottonBarNavegador extends StatefulWidget {
  @override
  _BottonBarNavegador createState() => _BottonBarNavegador();
}

class _BottonBarNavegador extends State<BottonBarNavegador> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(),
        child: BottomNavigationBar(
          // backgroundColor: Theme.of(context).primaryColor,
          // selectedItemColor: Colors.pink,
          // unselectedItemColor: Color.fromRGBO(166, 117, 152, 1.0),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Colors.green, size: 30.0),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.supervised_user_circle,
                  size: 30.0,
                ),
                label: 'Super'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}
// Widget bottonBarNavegador(BuildContext context) {
//   return Theme(
//       data: Theme.of(context).copyWith(),
//       child: BottomNavigationBar(
//         // backgroundColor: Theme.of(context).primaryColor,
//         // selectedItemColor: Colors.pink,
//         // unselectedItemColor: Color.fromRGBO(166, 117, 152, 1.0),
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined, color: Colors.green, size: 30.0),
//             label: 'Inicio',
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.supervised_user_circle,
//                 size: 30.0,
//               ),
//               label: 'Super'),
//         ],
//               currentIndex: _selectedIndex,
//       selectedItemColor: Colors.amber[800],
//       onTap: _onItemTapped,
//       ));
// }
