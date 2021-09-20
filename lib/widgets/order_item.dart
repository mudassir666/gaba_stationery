import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gaba_stationery/models/order.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  //const OrderItem({ Key? key }) : super(key: key);
  final OrderBlueprint order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var more = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "\$${widget.order.totalAmount}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    more = !more;
                  });
                },
                icon: more ? Icon(Icons.north) : Icon(Icons.south),
                color: more ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark ,
              ),
            ),
            if (more)
              // SizedBox(height: 6),
              // Divider(),
              Container(
                // height: min(widget.order.stationeries.length * 20.0 + 10, 100),
                height: 100,
                child: ListView.builder(
                    itemCount: widget.order.stationeries.length,
                    itemBuilder: (ctx, i) {
                      return ListTile(
                        leading: Text(
                          widget.order.stationeries[i].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        trailing: FittedBox(
                          child: Text(
                            "${widget.order.stationeries[i].quantity}x \$${widget.order.stationeries[i].quantity * widget.order.stationeries[i].price}",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    }),
              )
          ],
        ),
      ),
    );
  }
}
