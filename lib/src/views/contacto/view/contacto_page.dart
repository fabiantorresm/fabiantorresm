
import 'package:fabiantorresm/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactoPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ContactoPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacto'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Cantáctanos',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Nosotros Invitamos El Café',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Av. San Luis Gonzaga 5384, Zapopan, Jalisco',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                )),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  image: DecorationImage(
                    image: AssetImage("assets/images/Hero-Home-page-new.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                //child:
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: primaryDarkColor,
                child: Center(
                    child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      height: 50,
                      minWidth: 100,
                      child: Icon(
                        LineIcons.phone,
                        color: primaryDarkColor,
                      ),
                      color: Colors.white,
                      onPressed: () async {
                        _launchPhone('331-7370-485');
                      },
                    ),
                    FlatButton(
                      height: 50,
                      minWidth: 100,
                      child: Icon(
                        LineIcons.internet_explorer,
                        color: primaryDarkColor,
                      ),
                      color: Colors.white,
                      onPressed: () async {
                        _launchURL('https://www.inprodi.mx');
                      },
                    ),
                    FlatButton(
                      height: 50,
                      minWidth: 100,
                      child: Icon(
                        LineIcons.map,
                        color: primaryDarkColor,
                      ),
                      color: Colors.white,
                      onPressed: () async {
                        _launchMap();
                      },
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchPhone(String telephoneNumber) async {
    String telephoneUrl = "tel:$telephoneNumber";
    if (await canLaunch(telephoneUrl)) {
      await launch(telephoneUrl);
    } else {
      throw "Can't phone that number.";
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchMap() async {
    final String lat = "20.6637035";
    final String lng = "-103.4329798";
    final String googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

    // if (Platform.isAndroid) {
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
    // }

    // if (Platform.isIOS) {
    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      throw "Couldn't launch URL";
    }
    // }
  }
}
