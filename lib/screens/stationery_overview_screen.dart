import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/cart.dart';
import 'package:gaba_stationery/screens/cart_screen.dart';
import 'package:gaba_stationery/widgets/badge.dart';
import 'package:gaba_stationery/widgets/drawer_widget.dart';

import 'package:gaba_stationery/widgets/stationery_grid.dart';
import 'package:provider/provider.dart';

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
            ],
          ),
          Consumer<Cart>(
            builder: (ctx, cart, child) => Badge(
              child: child as Widget,
              value: cart.itemCount.toString(),
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart_sharp),
            ),
          )
        ],
      ),
      body: StationeryGrid(_showOnlyFavorite),
      drawer: DrawerWidget(),
    );
  }
}
