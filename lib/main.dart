import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/cart.dart';
import 'package:gaba_stationery/models/stationery.dart';
import 'package:gaba_stationery/screens/cart_screen.dart';
import 'package:gaba_stationery/screens/order_screen.dart';
import 'package:gaba_stationery/screens/stationery_detail_screen.dart';
import 'package:gaba_stationery/screens/stationery_overview_screen.dart';
import 'package:provider/provider.dart';

import 'models/order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Stationery()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Order()),
      ],
      child: MaterialApp(
        title: 'Gaba Stationery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.blueGrey,
        ),
        home: StationeryOverviewScreen(),
        routes: {
          StationeryDetailScreen.routeName: (ctx) => StationeryDetailScreen(),
          CartScreen.routeName : (ctx) => CartScreen(),
          OrderScreen.routeName : (ctx) => OrderScreen(),
        },
      ),
    );
  }
}
