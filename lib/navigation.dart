import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mercato_app/features/drugs/presentation/pages/drugs_pages/main_page.dart';
import 'features/drugs/presentation/pages/drugs_pages/barcode_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}
List<Widget>pages=[
  MainPage(),
  BarcodePage(),

];
int activeIndex = 0;
final navigationKey = GlobalKey<CurvedNavigationBarState>();

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: true,
      right: true,
      child: Scaffold(

        bottomNavigationBar:   CurvedNavigationBar( items: [
           FaIcon(FontAwesomeIcons.magnifyingGlass,color: Colors.white),
           FaIcon( FontAwesomeIcons.barcode,color: Colors.white,),
        ],
          key: navigationKey,
          index: activeIndex,
          onTap: (index) => setState(() {
            activeIndex = index;
          }),
          backgroundColor: Colors.transparent,
          color: Colors.blue[800]!,
          height: 60,
          animationCurve: Curves.fastOutSlowIn,
          buttonBackgroundColor: Colors.blue[800]!,


        ),
        body: pages[activeIndex] ,

      ),
    );
  }
}
