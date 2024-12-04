import 'package:flutter/material.dart';

class CropsItemListPage extends StatelessWidget {
  const CropsItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crops Item List'),
        backgroundColor: const Color(0xFF00B341), // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Crops Available for Purchase:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 10, // Example count, replace with actual data length
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Handle item tap (e.g., navigate to product details)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Selected crop item $index')),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/wheat.png', // Example crop image, replace as needed
                            width: 90,
                            height: 90,
                          ),
                          Text(
                            'Crops Item $index', // Replace this with the name of the seed item
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF6D6D6D),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹100', // You can replace this with dynamic pricing
                            style: const TextStyle(
                              color: Color(0xFF00B341),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
