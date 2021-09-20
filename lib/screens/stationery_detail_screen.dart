import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/stationery.dart';
import 'package:provider/provider.dart';

class StationeryDetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final stationeryId = ModalRoute.of(context)!.settings.arguments as String;
    final stationery =
        Provider.of<Stationery>(context, listen: false).findById(stationeryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(stationery.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: FittedBox(
                child: Image.network(
                  stationery.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "\$${stationery.price}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${stationery.description}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
