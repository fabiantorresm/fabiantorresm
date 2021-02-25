import 'package:fabiantorresm/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  final Stream<int> _periodicStream =
      Stream.periodic(const Duration(milliseconds: 1000), (i) => i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: StreamBuilder(
            stream: this._periodicStream,
            builder: (context, AsyncSnapshot<int> snapshot) {
              return SpintKitWidgetCube();
            }),
      ),
    ));
  }
}
