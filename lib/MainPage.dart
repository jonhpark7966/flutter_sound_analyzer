import 'package:flutter/material.dart';
import 'TImeGraphView.dart';
import 'FFTGraphView.dart';
import 'ColorMapView.dart';

class MainPage extends StatefulWidget{
  MainPage({Key key}) : super(key:key);

  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    TimeGraphView(),
    FFTGraphView(),
    ColorMapView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Time',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Frequency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Colormap',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}