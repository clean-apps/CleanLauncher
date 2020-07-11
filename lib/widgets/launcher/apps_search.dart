import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:CleanLauncher/stores/models/appData.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';

class AppsSearchWidget extends StatefulWidget {
  List<AppData> apps;

  AppsSearchWidget(this.apps);

  @override
  _AppsSearchState createState() => _AppsSearchState();
}

class _AppsSearchState extends State<AppsSearchWidget> {
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
    showApps = widget.apps.toList();
    if (searchString != null && searchString.length > 0) {
      setState(() {
        showApps.retainWhere(
          (ele) =>
              ele.appName.toUpperCase().contains(searchString.toUpperCase()),
        );
      });
    } else {
      setState(() {
        showApps = widget.apps.toList();
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
    Color themeColor = Theme.of(context).textTheme.headline3.color;
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    return AlphabetListScrollView(
      strList: this.showApps.map((e) => e.appName).toList(),
      indexedHeight: (i) => 60,
      itemBuilder: (context, index) {
        AppData appData = this.showApps.elementAt(index);
        return FlatButton(
          onPressed: () => DeviceApps.openApp(appData.packageName),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              appData.appName,
              style: Theme.of(context).textTheme.headline3,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
        );
      },
      keyboardUsage: true,
      normalTextStyle: TextStyle(color: themeColor),
      highlightTextStyle: TextStyle(color: highlightColor),
      headerWidgetList: <AlphabetScrollListHeader>[
        AlphabetScrollListHeader(
          widgetList: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _renderSearchBox(themeColor, highlightColor),
            )
          ],
          icon: Icon(Icons.search, color: highlightColor),
          indexedHeaderHeight: ((index) => 80),
        ),
      ],
    );
  }
}
