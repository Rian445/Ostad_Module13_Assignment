import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int pulloverQty = 1;
  int tshirtQty = 1;
  int dressQty = 1;

  final double pulloverPrice = 250.0;
  final double tshirtPrice = 250.0;
  final double dressPrice = 500.0;
  final double discountAmount = 100.0;
  double discount = 0.0;

  final TextEditingController promoCodeController = TextEditingController();

  double get totalAmount {
    return (pulloverQty * pulloverPrice) +
        (tshirtQty * tshirtPrice) +
        (dressQty * dressPrice) -
        discount;
  }

  void applyPromoCode() {
    setState(() {
      if (promoCodeController.text == 'Ostad') {
        discount = discountAmount;
      } else {
        discount = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            buildItemCard(
              buildItemRow('Pullover', 'Color: Red', 'Size: L', pulloverPrice,
                  pulloverQty, (newQty) {
                setState(() {
                  pulloverQty = newQty;
                });
              }, 'assets/images/pullover.png'),
            ),
            buildItemCard(
              buildItemRow(
                  'T-Shirt', 'Color: Orange', 'Size: L', tshirtPrice, tshirtQty,
                  (newQty) {
                setState(() {
                  tshirtQty = newQty;
                });
              }, 'assets/images/tshirt.png'),
            ),
            buildItemCard(
              buildItemRow('Sport Dress', 'Color: Yellow', 'Size: M',
                  dressPrice, dressQty, (newQty) {
                setState(() {
                  dressQty = newQty;
                });
              }, 'assets/images/dress.png'),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: promoCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Promo Code',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  onPressed: applyPromoCode,
                  child: Text(
                    'Apply',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Use "Ostad" Promocode to get 100 Taka discount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total amount:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '৳${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text('Checkout successful!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                'CHECK OUT',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemCard(Widget child) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  Widget buildItemRow(String title, String subtitle1, String subtitle2,
      double price, int qty, Function(int) onQtyChanged, String imagePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            Image.asset(
              imagePath,
              height: 50,
              width: 50,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(subtitle1),
                Text(subtitle2),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            buildIconButton(Icons.remove, () {
              if (qty > 1) {
                onQtyChanged(qty - 1);
              }
            }),
            SizedBox(width: 8),
            Text(qty.toString(), style: TextStyle(fontSize: 16)),
            SizedBox(width: 8),
            buildIconButton(Icons.add, () {
              onQtyChanged(qty + 1);
            }),
          ],
        ),
        Text('৳${price.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget buildIconButton(IconData icon, VoidCallback onPressed) {
    return Material(
      elevation: 2,
      shape: CircleBorder(),
      color: Colors.white,
      child: IconButton(
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
        color: Colors.black,
        splashRadius: 20,
        padding: EdgeInsets.all(4),
      ),
    );
  }
}
