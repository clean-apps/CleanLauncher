import 'package:flutter/material.dart';
import 'package:CleanLauncher/stores/models/appData.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/applist.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';

final AppList appList = StoreBuilder.favorites();

class SelectAppsWidget extends StatefulWidget {
  @override
  _SelectAppsWidget createState() => _SelectAppsWidget();
}

class _SelectAppsWidget extends State<SelectAppsWidget> {
  //
  List<AppData> showApps = List();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _doSearch(null);
    searchController.addListener(() {
      _doSearch(searchController.text);
    });
  }

  void _doSearch(String searchString) {
    showApps = appList.allApps.toList();
    if (searchString != null && searchString.length > 0) {
      setState(() {
        showApps.retainWhere(
          (ele) => ele.appName.toUpperCase().contains(
                searchString.toUpperCase(),
              ),
        );
      });
    } else {
      setState(() {
        showApps = appList.allApps.toList();
      });
    }
  }

  Widget _renderSearchBox(Color themeColor, Color highlightColor) {
    return Theme(
      data: ThemeData(
        primaryColor: highlightColor,
        primaryColorDark: highlightColor,
      ),
      child: TextFormField(
        controller: searchController,
        style: TextStyle(
          color: themeColor,
          decoration: TextDecoration.none,
        ),
        autofocus: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: new BorderSide(color: highlightColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(color: highlightColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: new BorderSide(color: highlightColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: new BorderSide(color: highlightColor),
          ),
          suffix: Icon(
            Icons.search,
            color: highlightColor,
          ),
          labelText: "Search",
          labelStyle: TextStyle(
            color: highlightColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color normalColor = Theme.of(context).textTheme.headline3.color;
    Color highlightColor = Theme.of(context).textTheme.caption.color;

    TextStyle normalStyle = Theme.of(context).textTheme.headline3;
    TextStyle highlightStyle = normalStyle.copyWith(color: highlightColor);

    return AlphabetListScrollView(
      strList: this.showApps.map((e) => e.appName).toList(),
      indexedHeight: (i) => 60,
      itemBuilder: (context, index) {
        AppData appData = this.showApps.elementAt(index);
        return Observer(
          builder: (_) => FlatButton(
            onPressed: () => appList.isContains(appData)
                ? appList.remove(appData)
                : appList.add(appData),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                appData.appName,
                style:
                    appList.isContains(appData) ? highlightStyle : normalStyle,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        );
      },
      keyboardUsage: true,
      normalTextStyle: TextStyle(color: normalColor),
      highlightTextStyle: TextStyle(color: highlightColor),
      headerWidgetList: <AlphabetScrollListHeader>[
        AlphabetScrollListHeader(
          widgetList: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _renderSearchBox(normalColor, highlightColor),
            )
          ],
          icon: Icon(Icons.search, color: highlightColor),
          indexedHeaderHeight: ((index) => 80),
        ),
      ],
    );
  }
}
