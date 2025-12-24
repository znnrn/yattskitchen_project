import 'package:flutter/material.dart';
import 'popular_food_cart.dart'; 
import 'my_cart_page.dart'; // Import will now be used below

// --- FOOD ITEM DATA MODEL ---
class FoodItem {
  final String name;
  final String description;
  final String? price;
  final double? rating;
  final String? time;
  final String category;
  final bool isPopular;
  final String imagePath; // Required for images

  FoodItem({
    required this.name,
    required this.description,
    this.price,
    this.rating,
    this.time,
    required this.category,
    this.isPopular = false,
    required this.imagePath,
  });
}

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  String _selectedCategory = 'All'; 
  String _searchQuery = ''; 

  final List<FoodItem> _allFoodItems = [
    FoodItem(
        name: 'Nasi Goreng Special',
        description: 'Special fried rice with chicken and vegetables',
        category: 'Rice',
        isPopular: true, 
        price: '8.50',
        imagePath: 'assets/nasigorengspecial.jpg',
    ),
    FoodItem(
        name: 'Laksa Sarawak',
        description: 'Authentic Sarawakian spicy noodle soup',
        category: 'Noodles',
        isPopular: true, 
        price: '7.00',
        imagePath: 'assets/nasigorengspecial.jpg',
    ),
    FoodItem(
        name: 'Chicken Wings',
        description: 'Crispy fried chicken wings',
        category: 'Sides',
        price: '5.00',
        imagePath: 'assets/nasigorengspecial.jpg',
    ),
    FoodItem(
        name: 'Char Kuey Teow',
        description: 'Stir-fried flat rice noodles with prawns and eggs',
        category: 'Noodles',
        price: '6.50',
        imagePath: 'assets/nasigorengspecial.jpg',
    ),
    FoodItem(
        name: 'Steamed Vegetables',
        description: 'Fresh mixed vegetables steamed to perfection',
        category: 'Sides',
        price: '4.00',
        imagePath: 'assets/nasigorengspecial.jpg',
    ),
    FoodItem(
        name: 'Nasi Lemak',
        description: 'Coconut milk rice with sambal and fried anchovies',
        category: 'Rice',
        isPopular: true, 
        price: '7.50',
        imagePath: 'assets/nasigorengspecial.jpg',
    ),
    // Add more items as needed...
  ];

  List<FoodItem> get _filteredFoodItems {
    final query = _searchQuery.toLowerCase();
    return _allFoodItems.where((item) {
      final matchesQuery = item.name.toLowerCase().contains(query);
      final matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EBDD),
      appBar: AppBar(
        toolbarHeight: 180,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: _buildHeader(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildCategoryRow(),
              const SizedBox(height: 30),
              _buildFoodGrid(context),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF1C40F), Color(0xFFE67E22)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Yatt's Kitchen", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const Text("Pavilion Unimas", style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
              const Icon(Icons.notifications_none, size: 28),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            onChanged: (val) => setState(() => _searchQuery = val),
            decoration: InputDecoration(
              hintText: 'Search Delicious Food',
              prefixIcon: const Icon(Icons.search),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow() {
    final categories = ['All', 'Rice', 'Noodles', 'Sides'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final bool isSelected = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = cat),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFF39C12) : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(cat, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFoodGrid(BuildContext context) {
    final filteredItems = _filteredFoodItems;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return PopularFoodCard(item: filteredItems[index]);
      },
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        if (index == 1) { // 0: Home, 1: Cart
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyCartPage()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ""),
      ],
    );
  }
}