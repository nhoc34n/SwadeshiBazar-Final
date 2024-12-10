import 'package:flutter/material.dart';
import 'PaymentPage.dart'; // Import your PaymentPage

class CropsItemListPage extends StatefulWidget {
  const CropsItemListPage({super.key});

  @override
  _CropsItemListPageState createState() => _CropsItemListPageState();
}

class _CropsItemListPageState extends State<CropsItemListPage> {
  // List of Crops Items with images, names, and prices
  final List<Map<String, dynamic>> cropItems = [
    {'image': 'assets/wheat.jpg', 'name': 'Wheat', 'price': 100.0},
    {'image': 'assets/rice.jpg', 'name': 'Rice', 'price': 120.0},
    {'image': 'assets/maize.jpg', 'name': 'Maize', 'price': 80.0},
    {'image': 'assets/barley.jpg', 'name': 'Barley', 'price': 90.0},
    {'image': 'assets/sugarcane.jpg', 'name': 'Sugarcane', 'price': 150.0},
  ];

  final List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B341),
        title: const Text('Crops Item List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the Cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cartItems: cartItems,
                    onRemoveItem: (index) {
                      setState(() {
                        cartItems.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: cropItems.length,
          itemBuilder: (context, index) {
            var item = cropItems[index];
            return GestureDetector(
              onTap: () {
                addToCart(item);
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item['image'],
                      width: 90,
                      height: 90,
                    ),
                    Text(
                      item['name'],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '৳${item['price']}', // Changed currency symbol
                      style: const TextStyle(fontSize: 12, color: Colors.green),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final void Function(int index) onRemoveItem;

  const CartPage(
      {super.key, required this.cartItems, required this.onRemoveItem});

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItems.fold(0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B341),
        title: const Text('Your Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Your cart is empty.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        var item = cartItems[index];
                        return ListTile(
                          leading: Image.asset(
                            item['image'],
                            width: 40,
                            height: 40,
                          ),
                          title: Text(item['name']),
                          subtitle: Text('৳${item['price']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              onRemoveItem(index); // Immediately remove item
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${item['name']} removed from the cart'),
                                  duration: const Duration(
                                      milliseconds:
                                          200), // Set the duration of the SnackBar
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total: ৳$totalAmount',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: cartItems.isNotEmpty
                  ? () {
                      // Navigate to PaymentPage if cart is not empty
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentPage(totalPrice: totalAmount),
                        ),
                      );
                    }
                  : () {
                      // Show message if cart is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please Select one item'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
