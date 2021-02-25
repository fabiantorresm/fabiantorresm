import 'package:cached_network_image/cached_network_image.dart';
import 'package:fabiantorresm/src/logic/logic.dart';
import 'package:fabiantorresm/src/theme.dart';
import 'package:fabiantorresm/src/views/home/home.dart';
import 'package:fabiantorresm/src/views/views.dart';
import 'package:fabiantorresm/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fabiantorresm/src/models/models.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

final List posts = [];

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ScreenHiddenDrawer> items = new List();
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    return Scaffold(
      key: _drawerKey,
      drawer: MyDrawer(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            mySliverAppBar(context, _drawerKey),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.0,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Center(
                      child: Text(
                        'Nuestro blog',
                        style: TextStyle(
                            color: primaryDarkColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                print(state.props);
                if (state is PostSuccess) {
                  print('Obtenidos: => ${state.posts.length}');
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      var pet = state.posts[index];
                      if (state.posts.length <= 0)
                        return SliverToBoxAdapter(
                          child: SizedBox(
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      else
                        return itemCard(context, pet);
                    }, childCount: state.posts.length),
                  );
                }

                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 500,
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text('Cargando datos...',
                            style: TextStyle(fontSize: 20))
                      ],
                    )),
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget mySliverAppBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  return SliverAppBar(
    pinned: true,
    centerTitle: true,
    title: Text(
      'Inprodi',
      style: TextStyle(color: primaryDarkColor, fontSize: 30),
    ),
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: primaryDarkColor,
      ),
      onPressed: () {
        key.currentState.openDrawer(); // open drawer
      },
    ),
    actions: <Widget>[
      PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.replay_outlined, color: primaryDarkColor),
                Text('Refresh')
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.exit_to_app, color: primaryDarkColor),
                Text('Exit')
              ],
            ),
          ),
        ],
        initialValue: 2,
        onCanceled: () {
          print("Salir");
        },
        onSelected: (value) {
          switch (value) {
            case 1:
              context.read<PostBloc>().add(PostFetched());
              break;
            case 2:
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        elevation: 20,
                        title: const Text('Salir de Inprodi.mx'),
                        content: const Text('¿Deseas salir de la aplicación?'),
                        actions: [
                          FlatButton(
                              color: primaryDarkColor,
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancelar')),
                          FlatButton(
                              color: primaryDarkColor,
                              onPressed: () => context
                                  .read<AuthenticationBloc>()
                                  .add(AuthenticationLogoutRequested()),
                              child: Text('Aceptar'))
                        ],
                      ));
              break;
            default:
          }
        },
        icon: Icon(
          Icons.more_vert,
          color: primaryDarkColor,
        ),
      )
    ],
    floating: false,
  );
}

Widget itemCard(BuildContext context, Post item) {
  return InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PostDetails(post: item);
    })),
    child: Hero(
      tag: item.id,
      child: Container(
          height: 200,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    item.imageUrl,
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                    offset: Offset(2.0, 10.0))
              ]),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(item.title,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        )),
                  ))
            ],
          )),
    ),
  );
}
