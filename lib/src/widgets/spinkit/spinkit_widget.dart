import 'package:fabiantorresm/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpintKitWidgetCube extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? primaryDarkColor : primaryLigthColor,
          ),
        );
      },
    );
  }
}

class SpintKitWidgetChasingDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? primaryDarkColor : primaryLigthColor,
          ),
        );
      },
    );
  }
}
