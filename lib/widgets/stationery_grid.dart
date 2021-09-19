import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/stationery.dart';
import 'package:gaba_stationery/widgets/stationery_item.dart';
import 'package:provider/provider.dart';

class StationeryGrid extends StatelessWidget {
  final bool favorite;

  StationeryGrid(this.favorite);

  @override
  Widget build(BuildContext context) {
    final stationeryData = Provider.of<Stationery>(context);
    final stationery =
        favorite ? stationeryData.favoriteItem : stationeryData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: stationery[i],
        child: StationeryItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      itemCount: stationery.length,
    );
  }
}
