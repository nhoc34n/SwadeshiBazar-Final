import 'package:flutter/material.dart';
import 'package:swadeshi_bazar/SeedItemListPage.dart'; // Import the SeedItemListPage
import 'package:swadeshi_bazar/account_page.dart';
import 'package:swadeshi_bazar/CropsItemListPage.dart';
import 'package:swadeshi_bazar/LivestockItemListPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swadeshi Bazar',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(userType: "Consumer"), // Example: Pass userType
    );
  }
}

class HomePage extends StatefulWidget {
  final String userType;

  const HomePage({super.key, required this.userType});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isBuySelected = false;
  bool isSellSelected = false;

  late String userType;

  @override
  void initState() {
    super.initState();
    userType = widget.userType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header Bar
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF00B341),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Swadeshi Bazar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // Notification icon action
                    },
                  ),
                ],
              ),
            ),
            // Buy and Sell Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isBuySelected
                          ? const Color.fromARGB(255, 0, 255, 34)
                          : Colors.white,
                      foregroundColor: isBuySelected
                          ? const Color(0xFF00B341)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isBuySelected = true;
                        isSellSelected = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Buy mode enabled"),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                    child: const Text(
                      'Buy Product',
                      style: TextStyle(color: Color(0xFF00B341)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (userType == "Farmer")
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSellSelected
                            ? const Color.fromARGB(255, 0, 255, 34)
                            : Colors.white,
                        foregroundColor: isSellSelected
                            ? const Color(0xFF00B341)
                            : Colors.black,
                      ),
                      onPressed: () {
                        if (userType == "Farmer") {
                          setState(() {
                            isSellSelected = true;
                            isBuySelected = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sell mode enabled"),
                              duration: Duration(milliseconds: 500),
                            ),
                          );
                        } else {
                          setState(() {
                            isSellSelected = false;
                            isBuySelected = true;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Only farmers can add items to sell")),
                          );
                        }
                      },
                      child: const Text(
                        'Sell Product',
                        style: TextStyle(color: Color(0xFF00B341)),
                      ),
                    ),
                  if (userType == "Consumer")
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Only farmers can add items to sell"),
                          ),
                        );
                      },
                      child: const Text(
                        'Sell Product',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                ],
              ),
            ),
            // Banner Section
            Image.asset(
              'assets/add.png',
              width: MediaQuery.of(context).size.width,
              height: 100,
              fit: BoxFit.cover,
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Product',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                ),
              ),
            ),
            // Buy Grid Layout
            if (isBuySelected)
              Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    categoryCard('Seed', 'assets/seed.png'),
                    categoryCard('Crops', 'assets/wheat.png'),
                    categoryCard('Livestock', 'assets/livestock.png'),
                    categoryCard('Vegetables', 'assets/vegetable.png'),
                    categoryCard('Homemade', 'assets/hmade.png'),
                  ],
                ),
              ),
            // Sell Grid Layout
            if (isSellSelected)
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Items:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF199B33),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      children: [
                        categoryCard('Seed', 'assets/seed.png'),
                        categoryCard('Crops', 'assets/wheat.png'),
                        categoryCard('Livestock', 'assets/livestock.png'),
                        categoryCard('Vegetables', 'assets/vegetable.png'),
                        categoryCard('Homemade', 'assets/hmade.png'),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF00B341)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Color(0xFF00B341)),
            label: 'Buy/Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet, color: Color(0xFF00B341)),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Color(0xFF00B341)),
            label: 'Account',
          ),
        ],
        onTap: (index) {
          if (index == 3) {
            // Navigate to AccountPage when Account tab is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountPage()),
            );
          }
        },
      ),
    );
  }

  // Category Card Widget
  Widget categoryCard(String title, String asset) {
    return GestureDetector(
      onTap: () {
        if (isBuySelected && title == 'Seed') {
          // Navigate to SeedItemListPage when 'Seed' category is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SeedItemListPage()),
          );
        } else if (isBuySelected && title == 'Crops') {
          // Navigate to CropsItemListPage when 'Crops' category is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CropsItemListPage()),
          );
        } else if (!isBuySelected) {
          // If 'Sell Product' mode is selected, show a SnackBar or do something else
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("You can only view products in Buy mode")),
          );
        } else if (isBuySelected && title == 'Livestock') {
          // Navigate to LivestockItemListPage when 'Livestock' category is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LivestockItemListPage()),
          );
        } else {
          // For other categories, show a SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Selected: $title")),
          );
        }
      },
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset, width: 50, height: 50),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
