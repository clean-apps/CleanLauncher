import 'package:CleanLauncher/stores/models/appdata.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/applist.dart';

final AppList appList = StoreBuilder.favorites();

class ReorderFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Reorder Favorites',
          style: TextStyle(color: Theme.of(context).textTheme.headline4.color),
        ),
        elevation: 0.0,
      ),
      body: Observer(
        builder: (_) => ReorderableListView(
          onReorder: (oldIdx, newIdx) => appList.switchItems(oldIdx, newIdx),
          children: <Widget>[
            for (AppData appData in appList.apps)
              ListTile(
                key: Key(appData.appName),
                title: Text(
                  appData.appName,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.headline3,
                ),
                trailing: Icon(Icons.view_headline, color: highlightColor),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/launcher'),
        label: Text('NEXT', style: TextStyle(color: highlightColor)),
        icon: Icon(Icons.keyboard_arrow_right, color: highlightColor),
      ),
    );
  }
}
