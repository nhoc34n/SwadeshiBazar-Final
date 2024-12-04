import 'package:flutter/material.dart';

class SeedItemListPage extends StatelessWidget {
  const SeedItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B341),
        title: const Text('Seed Item List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality if needed
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
          itemCount:
              10, // You can modify this based on the number of seed items you have
          itemBuilder: (context, index) {
            return SeedItemCard(index: index);
          },
        ),
      ),
    );
  }
}

class SeedItemCard extends StatelessWidget {
  final int index;

  const SeedItemCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap on seed item, such as showing more details
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected Seed Item $index")),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/coriander.jpg', // You can change this to a dynamic image based on the item
              width: 90,
              height: 90,
            ),
            Text(
              'Seed Item $index', // Replace this with the name of the seed item
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
  }
}
