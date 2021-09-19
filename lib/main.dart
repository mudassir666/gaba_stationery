import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/stationery.dart';
import 'package:gaba_stationery/screens/stationery_detail_screen.dart';
import 'package:gaba_stationery/screens/stationery_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Stationery(),
      child: MaterialApp(
        title: 'Gaba Stationery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.blueGrey,
        ),
        home: StationeryOverviewScreen(),
        routes: {
          StationeryDetailScreen.routeName : (ctx) => StationeryDetailScreen(),
        },
      ),
    );
  }
}
