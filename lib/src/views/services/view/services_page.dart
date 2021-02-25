import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ServicesPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nuestros servicios'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            _buildFeaturedItem(
                image:
                    'https://revirnegocios.com.br/wp-content/uploads/2018/05/04-susu-couto-redes-sociais-mais-usadas-no-brasil-capa.jpg',
                subtitle: 'Creamos tu contenido y una estrategia integral.',
                title: 'Redes Sociales'),
            _buildFeaturedItem(
                image:
                    'https://cdn.pixabay.com/photo/2020/02/24/04/26/web-design-4875186_960_720.jpg',
                subtitle:
                    'Llevamos tu empresa al mundo digital con el mejor diseño.',
                title: 'Diseño Web'),
            _buildFeaturedItem(
                image:
                    'https://cdn.pixabay.com/photo/2016/05/11/11/03/google-1385511_960_720.jpg',
                subtitle:
                    'Creamos campañas publicitarias para que domines tu mercado.',
                title: 'Google Ads'),
            _buildFeaturedItem(
                image:
                    'https://cdn.pixabay.com/photo/2020/09/07/20/38/website-5552822_960_720.png',
                subtitle: 'Creamos software a la medida para tu empresa.',
                title: 'Desarrollo De Software'),
            _buildFeaturedItem(
                image:
                    'https://cdn.pixabay.com/photo/2017/06/12/03/33/seo-2394237_960_720.jpg',
                subtitle:
                    'Posicionamos tu sitio web en los principales buscadores.',
                title: 'SEO'),
            _buildFeaturedItem(
                image:
                    'https://cdn.pixabay.com/photo/2016/03/02/07/30/abstract-1231870_960_720.jpg',
                subtitle: 'Desde tu logotipo hasta toda la imagen de tu marca.',
                title: 'Diseño Gráfico'),
          ],
        )));
  }

  Widget _buildFeaturedItem({String image, String title, String subtitle}) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
      child: Material(
        elevation: 16.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: Colors.red),
                )),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                color: Colors.black.withOpacity(0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text(subtitle, style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
