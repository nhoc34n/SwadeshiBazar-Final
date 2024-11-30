import 'package:flutter/material.dart';
import 'package:swadeshi_bazar/account_page.dart';

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

  // Dynamically set userType based on login
  late String userType;

  @override
  void initState() {
    super.initState();
    userType = widget.userType; // Assign passed userType
  }

  @override
  Widget build(BuildContext context) {
    print("User type is: $userType"); // Debugging: Check the value of userType

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
                  Expanded(
                    child: const Text(
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
                      // Show SnackBar for Buy mode
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Buy mode enabled"),
                          duration:
                              const Duration(milliseconds: 500), // 0.5 seconds
                        ),
                      );
                    },
                    child: const Text(
                      'Buy Product',
                      style: TextStyle(color: Color(0xFF00B341)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Only show the "Sell Product" button for Farmer
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
                            // Show Sell Grid and hide Buy Grid
                            isSellSelected = true;
                            isBuySelected = false;
                          });

                          // Show a SnackBar for success
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Sell mode enabled"),
                              duration: const Duration(
                                  milliseconds: 500), // 0.5 seconds
                            ),
                          );
                        } else {
                          setState(() {
                            // Prevent showing Sell Grid and keep Buy Grid visible
                            isSellSelected = false;
                            isBuySelected = true;
                          });

                          // Show a SnackBar for error
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
                  // Show message for Consumer if they try to press "Sell Product"
                  if (userType == "Consumer")
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        // Show message to consumers that only farmers can sell products
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
              'assets/add.png', // Replace with your banner image asset
              width: MediaQuery.of(context).size.width,
              height: 100,
              fit: BoxFit
                  .cover, // This ensures the image covers the width of the screen
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
                      'Add Items:', // The text you want to display
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
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home, color: Color(0xFF00B341)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart, color: Color(0xFF00B341)),
            label: 'Buy/Sell',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_balance_wallet,
                color: Color(0xFF00B341)),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle, color: Color(0xFF00B341)),
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

  Widget categoryCard(String title, String asset) {
    return GestureDetector(
      onTap: () {
        // Handle category selection
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected: $title")),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              asset,
              width: 90,
              height: 90,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF6D6D6D),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
