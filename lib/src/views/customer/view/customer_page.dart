import 'package:cached_network_image/cached_network_image.dart';
import 'package:fabiantorresm/src/logic/logic.dart';
import 'package:fabiantorresm/src/models/models.dart';
import 'package:fabiantorresm/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CustomerPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuestros clientes'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state is CustomerInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CustomerError) {
              return Container(
                  child: Center(
                child: Text('Problemas al cargar los datos'),
              ));
            }
            if (state is CustomerSuccess) {
              print(state.customers.length);
              return ListView.builder(
                  itemCount: state.customers.length,
                  itemBuilder: (context, index) {
                    return index >= state.customers.length
                        ? BottomLoader()
                        : CustomerWidget(customer: state.customers[index]);
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class CustomerWidget extends StatelessWidget {
  final Customer customer;

  const CustomerWidget({Key key, @required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 8,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 180.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: customer.urlImage,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: Colors.red),
                )),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text(
                        customer.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                color: primaryDarkColor,
                padding: EdgeInsets.all(16),
                onPressed: () async {
                  if (await canLaunch(customer.urlSite)) {
                    await launch(customer.urlSite);
                  } else {
                    throw 'Could not launch $customer.urlSite';
                  }
                },
                child: const Text('Navegar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
