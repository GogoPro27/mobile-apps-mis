import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothing Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:  MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  MainMenu({super.key});

  final List<Map<String, String>> clothingItems = [
    {
      "name": "T-shirt",
      "image": "assets/tshirt.png",
      "description": "Comfortable cotton T-shirt.",
      "price": "20 USD"
    },
    {
      "name": "Jeans",
      "image":  "assets/jeans.png",
      "description": "Stylish blue jeans.",
      "price": "40 USD"
    },
    {
      "name": "Jacket",
      "image":  "assets/jacket.png",
      "description": "Warm winter jacket.",
      "price": "60 USD"
    },
    {
      "name": "Sneakers",
      "image":  "assets/sneakers.png",
      "description": "Comfortable running sneakers.",
      "price": "50 USD"
    },
    {
      "name": "Cap",
      "image":  "assets/hat.png",
      "description": "Stylish cap for sunny days.",
      "price": "15 USD"
    },
    {
      "name": "Dress",
      "image":  "assets/dress.png",
      "description": "Elegant evening dress.",
      "price": "80 USD"
    },
    {
      "name": "Scarf",
      "image":  "assets/scarf.png",
      "description": "Warm wool scarf.",
      "price": "25 USD"
    },
    {
      "name": "Shorts",
      "image":  "assets/shorts.png",
      "description": "Comfortable summer shorts.",
      "price": "30 USD"
    },
    {
      "name": "Sandals",
      "image":  "assets/sandals.png",
      "description": "Lightweight summer sandals.",
      "price": "35 USD"
    },
    {
      "name": "Sweater",
      "image":  "assets/sweater.png",
      "description": "Cozy knit sweater.",
      "price": "45 USD"
    },
  ];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('223070')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical, // Makes the list vertical
          itemCount: clothingItems.length,
          itemBuilder: (context, index) {
            final item = clothingItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClothingDetails(item: item),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: 150, // Set a fixed height for each card
                  child: Row(
                    children: [
                      Image.asset(item['image']!, width: 100, fit: BoxFit.cover),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['name']!,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['price']!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
class ClothingDetails extends StatelessWidget {
  final Map<String, String> item;

  const ClothingDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item['name']!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(item['image']!, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(item['name']!, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Text(item['description']!),
            const SizedBox(height: 16),
            Text('Price: ${item['price']!}'),
          ],
        ),
      ),
    );
  }
}