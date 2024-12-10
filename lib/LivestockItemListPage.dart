import 'package:flutter/material.dart';

class LivestockItemListPage extends StatelessWidget {
  const LivestockItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B341),
        title: const Text('Livestock Item List'),
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
              10, // Modify this to match the number of livestock items you have
          itemBuilder: (context, index) {
            return LivestockItemCard(index: index);
          },
        ),
      ),
    );
  }
}

class LivestockItemCard extends StatelessWidget {
  final int index;

  const LivestockItemCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap on livestock item (e.g., navigate to item details page)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected Livestock Item $index")),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/livestock.png', // Replace with an actual image for livestock
              width: 90,
              height: 90,
            ),
            Text(
              'Livestock Item $index', // Replace with actual livestock item name
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF6D6D6D),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '₹1500', // Replace with dynamic pricing
              style: TextStyle(
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
