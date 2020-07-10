import 'package:flutter/material.dart';
import 'package:CleanLauncher/model/appData.dart';
import 'package:CleanLauncher/widgets/setup/select_apps.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/favorites.dart';

final Favorites favorites = StoreBuilder.favorites();

class SetupFavorites extends StatefulWidget {
  int selected = 0;
  @override
  _SetupFavoritesState createState() => _SetupFavoritesState();
}

class _SetupFavoritesState extends State<SetupFavorites> {
  selectApplication(AppData selected) {
    favorites.add(selected).then((_) => setState(() => widget.selected++));
  }

  unselectApplication(AppData unselected) {
    favorites.remove(unselected).then((_) => setState(
          () => widget.selected--,
        ));
  }

  doNext() {
    Navigator.pushNamed(context, '/launcher');
  }

  @override
  Widget build(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    TextStyle appTitleStyle = Theme.of(context).textTheme.headline5;
    TextStyle appActionStyle = Theme.of(context)
        .textTheme
        .headline4
        .copyWith(color: Theme.of(context).textTheme.caption.color);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Favorite Apps', style: appTitleStyle),
        actions: <Widget>[Text(favorites.countStr, style: appActionStyle)],
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: Observer(
        builder: (_) => SelectAppsWidget(
          favorites.allApps,
          favorites.apps,
          selectApplication,
          unselectApplication,
        ),
      ),
      floatingActionButton: favorites.count > 0
          ? FloatingActionButton.extended(
              onPressed: () => doNext(),
              label: Text('NEXT', style: TextStyle(color: highlightColor)),
              icon: Icon(Icons.keyboard_arrow_right, color: highlightColor),
            )
          : Container(),
    );
  }
}
