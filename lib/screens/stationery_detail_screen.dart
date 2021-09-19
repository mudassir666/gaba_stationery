import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/stationery.dart';
import 'package:provider/provider.dart';

class StationeryDetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final stationeryId = ModalRoute.of(context)!.settings.arguments as String;
    final stationery = Provider.of<Stationery>(context,listen: false).findById(stationeryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(stationery.title),
      ),
      body: Container(),
    );
  }
}
