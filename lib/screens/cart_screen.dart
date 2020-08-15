import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_practice_app/providers/orders.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart' as CartListItem;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartValues = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      'ORDER NOW!',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(cartValues, cart.totalAmount);
                      cart.clearCart();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) {
                  return CartListItem.CartItem(
                    id: cartValues[i].id,
                    productId: cart.items.keys.toList()[i],
                    title: cartValues[i].title,
                    price: cartValues[i].price,
                    quantity: cartValues[i].quantity,
                  );
                }),
          )
        ],
      ),
    );
  }
}
