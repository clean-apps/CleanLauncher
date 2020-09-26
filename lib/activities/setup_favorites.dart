import 'package:flutter/material.dart';
import 'package:CleanLauncher/widgets/setup/select_apps.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/applist.dart';

final AppList appList = StoreBuilder.favorites();

class SetupFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    Color highlightColor = _textTheme.caption.color;
    TextStyle appTitleStyle = _textTheme.headline5;
    TextStyle appActionStyle = _textTheme.headline4.copyWith(
      color: _textTheme.caption.color,
    );

    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Select Favorite Apps', style: appTitleStyle),
          actions: <Widget>[Text(appList.countStr, style: appActionStyle)],
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: SelectAppsWidget(),
        floatingActionButton: appList.count > 0
            ? FloatingActionButton.extended(
                onPressed: () =>
                    Navigator.popAndPushNamed(context, '/launcher'),
                label: Text('NEXT', style: TextStyle(color: highlightColor)),
                icon: Icon(Icons.keyboard_arrow_right, color: highlightColor),
              )
            : Container(),
      ),
    );
  }
}
