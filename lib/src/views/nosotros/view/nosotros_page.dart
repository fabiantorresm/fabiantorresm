import 'package:flutter/material.dart';

class NosotrosPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NosotrosPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nosotros'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: EdgeInsets.all(16),
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/logo-inprodi.png',
                    fit: BoxFit.fitWidth,
                  )),
              Container(
                padding: EdgeInsets.all(16),
                height: 120,
                width: double.infinity,
                child: Text(
                  'Nació un sueño'.toUpperCase(),
                  style: TextStyle(fontSize: 40, letterSpacing: 2),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(16),
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/undraw_Marketing_re_7f1g.png',
                    fit: BoxFit.cover,
                  )),
              Container(
                padding: EdgeInsets.all(16),
                height: 250,
                width: double.infinity,
                child: Text(
                  'Un par de laptops y una gran motivación de impactar de forma disruptiva en el ecosistema emprendedor.Así nació Inprodi, ahora somos una agencia de diseño web, software y marketing de nivel nacional, con un equipo que nos respalda a cada paso.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                height: 120,
                width: double.infinity,
                child: Text(
                  'Amamos lo Digital'.toUpperCase(),
                  style: TextStyle(fontSize: 40, letterSpacing: 2),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(16),
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/undraw_goals_w8tw.png',
                    fit: BoxFit.cover,
                  )),
              Container(
                padding: EdgeInsets.all(16),
                height: 300,
                width: double.infinity,
                child: Text(
                  'Nuestro objetivo siempre ha sido ofrecer soluciones simples para problemas complejos. Y creemos que las herramientas digitales son la llave perfecta para acceder al crecimiento de cualquier empresa, queremos ayudarte, sabemos como hacerlo.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ));
  }
}
