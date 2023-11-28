import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import 'Page1.dart';
class BottomNavigators extends StatefulWidget {

  @override
  State<BottomNavigators> createState() => _BottomNavigatorsState();
}
var sayfalistesi=[Page1(),MainPage(),pasra()];
int index=0;
class _BottomNavigatorsState extends State<BottomNavigators> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sayfalistesi[index],
      bottomNavigationBar: CurvedNavigationBar(
          items: const [
            FaIcon(FontAwesomeIcons.crown,color: Colors.white,),
            FaIcon(FontAwesomeIcons.solidFileWord,color: Colors.white,),
               FaIcon(FontAwesomeIcons.userLarge,color: Colors.white,)
          ],
          animationDuration: Duration(microseconds: 300),
          color: Colors.black,
          backgroundColor: Colors.white,
          index: index,
          onTap: (value){
            setState(() {
              index=value;
            });
          }
      ),
    );
  }
}