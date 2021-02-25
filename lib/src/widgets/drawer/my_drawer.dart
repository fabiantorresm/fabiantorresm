import 'package:fabiantorresm/src/theme.dart';
import 'package:fabiantorresm/src/views/views.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

Widget MyDrawer(BuildContext context) {
  final drawerItems = ListView(
    children: [
      SizedBox(
        height: 50,
      ),
      ListTile(
        trailing: Icon(LineIcons.arrow_right),
        title: Text(
          "Nosotros",
          style: TextStyle(fontSize: 22, color: primaryDarkColor),
        ),
        onTap: () {
          // Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return NosotrosPage();
          }));
        },
      ),
      ListTile(
        trailing: Icon(LineIcons.arrow_right),
        title: Text(
          "Clientes",
          style: TextStyle(fontSize: 22, color: primaryDarkColor),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return CustomerPage();
          }));
        },
      ),
      ListTile(
        trailing: Icon(LineIcons.arrow_right),
        title: Text(
          "Servicios",
          style: TextStyle(fontSize: 22, color: primaryDarkColor),
        ),
        onTap: () {
          // Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ServicesPage();
          }));
        },
      ),
      ListTile(
        trailing: Icon(LineIcons.arrow_right),
        title: Text(
          "Contacto",
          style: TextStyle(fontSize: 22, color: primaryDarkColor),
        ),
        onTap: () {
          // Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ContactoPage();
          }));
        },
      )
    ],
  );

  return Drawer(
    child: Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Stack(children: [
              Positioned(
                  bottom: 0,
                  child: Center(
                    child: Text(
                      'Realidad Digital',
                      style: TextStyle(fontSize: 22, color: primaryDarkColor),
                      softWrap: true,
                    ),
                  )),
            ]),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo-inprodi.png"),
                    fit: BoxFit.fitWidth)),
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ),
        Expanded(flex: 3, child: drawerItems)
      ],
    ),
  );
}
