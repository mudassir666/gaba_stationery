import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/order.dart';
import 'package:gaba_stationery/widgets/drawer_widget.dart';
import 'package:gaba_stationery/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // no new future will be create after doing this and the app will not rebuild again
  late Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Order>(context, listen: false).fetchStationery();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Order"),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapshot) {
          // checking if the data connection state is waiting or not
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // if error occur // falure
          else {
            if (dataSnapshot.error != null) {
              // do error handling stuff
              print(dataSnapshot.error);
              return Center(child: Text('An error occurred'));
            }
            // if everything run perfectly // success
            else {
              // use consumer for listview
              return Consumer<Order>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.order.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.order[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
