import 'package:flutter/material.dart';

import 'package:gaba_stationery/widgets/stationery_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class StationeryOverviewScreen extends StatefulWidget {
  @override
  _StationeryOverviewScreenState createState() =>
      _StationeryOverviewScreenState();
}

class _StationeryOverviewScreenState extends State<StationeryOverviewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gaba Stationery"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorite) {
                    _showOnlyFavorite = true;
                  } else {
                    _showOnlyFavorite = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert_sharp),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favorite'),
                      value: FilterOptions.Favorite,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOptions.All,
                    ),
                  ],)
        ],
      ),
      body: StationeryGrid(_showOnlyFavorite),
    );
  }
}
