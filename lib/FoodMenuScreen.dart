import 'package:flutter/material.dart';
import 'category_button.dart'; 
import 'popular_food_cart.dart'; 
import 'my_cart_page.dart'; 

// --- FOOD ITEM DATA MODEL ---

class FoodItem {
  final String name;
  final String description;
  final String? price;
  final double? rating;
  final String? time;
  final String category;
  final bool isPopular;

  FoodItem({
    required this.name,
    required this.description,
    this.price,
    this.rating,
    this.time,
    required this.category,
    this.isPopular = false,
  });
}

// --- MAIN SCREEN WIDGET (STATEFUL) ---

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  String _selectedCategory = 'All'; 
  String _searchQuery = ''; 

  // Full list of food items
  final List<FoodItem> _allFoodItems = [
    // --- POPULAR ITEMS (All categories) ---
    FoodItem(
        name: 'Nasi Goreng Special',
        description: 'Special fried rice with chicken and vegetables',
        category: 'Rice',
        isPopular: true, 
        price: '8.50',
        rating: 4.8),
    FoodItem(
        name: 'Laksa Sarawak',
        description: 'A flavorful spicy noodle dish with tamarind and creamy coconut milk',
        rating: 4.6,
        time: '12 min',
        price: '7.50',
        category: 'Noodles',
        isPopular: true),
    FoodItem(
        name: 'Ayam Belado',
        description: 'spicy sambal-coated fried chicken. sambal',
        category: 'Sides',
        isPopular: true, 
        price: '9.00',
        rating: 4.5),
    FoodItem(
        name: 'Ayam Penyet',
        description: 'crispy smashed chicken with sambal',
        rating: 4.9,
        time: '18 min',
        price: '10.00',
        category: 'Sides',
        isPopular: true),
    
    // --- RICE CATEGORY ITEMS ---
    FoodItem(
        name: 'Nasi Goreng Seafood',
        description: 'Fried rice cooked with fresh prawns, squid, and seafood seasoning',
        rating: 4.3,
        price: '9.50',
        category: 'Rice'),
    FoodItem(
        name: 'Nasi Ayam Korea',
        description: 'Korean-style crispy chicken with rice.',
        rating: 4.6,
        time: '12 min',
        price: '9.00',
        category: 'Rice'),
    FoodItem(
        name: 'Nasi Ayam Roasted',
        description: 'flavorful roasted chicken served with fragrant rice and savory sauce',
        rating: 4.9,
        time: '18 min',
        price: '10.00',
        category: 'Rice'),
    FoodItem(
        name: 'Nasi Ayam Steam',
        description: 'steamed chicken served with fragrant rice and light, savory sauce',
        rating: 4.9,
        time: '18 min',
        price: '10.00',
        category: 'Rice'),
    
    // --- NOODLES CATEGORY ITEMS ---
    FoodItem(
        name: 'Mee/Bihun KueyTeow Soup',
        description: 'Flavourful soup topped with chicken, herbs and fried onions',
        price: '7.00',
        category: 'Noodles'),
    FoodItem(
        name: 'Laksa Penang',
        description: 'A tangy, spicy tamarind-based noodle soup with mackerel, herbs, and fresh toppings',
        rating: 4.6,
        time: '20 min',
        price: '9.00',
        category: 'Noodles'),
    FoodItem(
        name: 'Mee Jawa',
        description: 'A sweet, mildly spicy noodle dish with thick gravy and toppings',
        rating: 4.9,
        time: '20 min',
        price: '9.00',
        category: 'Noodles'),
    FoodItem(
        name: 'Mee / Bihun Tomyam Soup',
        description: 'Spicy, sour soup with herbs and seafood or chicken.',
        rating: 4.9,
        time: '18 min',
        price: '10.00',
        category: 'Noodles'),

    // --- SIDES CATEGORY ITEMS ---
    FoodItem(
        name: 'Fries',
        description: 'Crispy, golden fried potato sticks.',
        category: 'Sides',
        price: '7.50',
        rating: 4.5), 
    FoodItem(
        name: 'Fried Wontons',
        description: 'Crispy deep-fried dumplings filled with seasoned meat or vegetables.',
        rating: 4.6,
        time: '20 min',
        price: '9.00',
        category: 'Sides'),
    FoodItem(
        name: 'Wanton Soup',
        description: 'Savory chicken and shrimp wontons served in a clear, lightly seasoned broth',
        rating: 4.9,
        time: '20 min',
        price: '7.00',
        category: 'Sides'),
    FoodItem(
        name: 'Bread Roll Sausage',
        description: 'A soft bread roll filled with a juicy sausage baked to golden perfection',
        rating: 4.9,
        time: '18 min',
        price: '2.00',
        category: 'Sides'),
    FoodItem(
        name: 'Spring Rolls',
        description: 'Vegetables and fillings wrapped in a thin, soft wheat-flour skin',
        rating: 4.5,
        time: '10 min',
        price: '2.00',
        category: 'Sides'),
    FoodItem(
        name: 'Kuih Muih',
        description: 'Variety of traditional bite-sized snacks or desserts',
        rating: 4.5,
        time: '10 min',
        price: '2.00',
        category: 'Sides'),
  ];

  List<FoodItem> get _filteredFoodItems {
    final normalizedQuery = _searchQuery.toLowerCase();
    
    // 1. If there is a search query, search ALL items regardless of category
    if (normalizedQuery.isNotEmpty) {
      return _allFoodItems.where((item) {
        // Search by name OR description
        return item.name.toLowerCase().contains(normalizedQuery) ||
               item.description.toLowerCase().contains(normalizedQuery);
      }).toList();
    } 
    // 2. If no search query, filter by category as before
    else {
      if (_selectedCategory == 'All') {
        // Show only popular items on the default "All" tab
        return _allFoodItems.where((item) => item.isPopular).toList();
      } else {
        // Show items matching the selected category
        return _allFoodItems
            .where((item) => item.category == _selectedCategory)
            .toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: <Widget>[
              const SizedBox(height: 20),
              
              _buildCategoryRow(),
              
              const SizedBox(height: 30),
              
              if (_selectedCategory == 'All' && _searchQuery.isEmpty) ...[
                _buildPopularHeader(),
                const SizedBox(height: 20),
              ],
              if (_searchQuery.isNotEmpty) ...[
                _buildSearchHeader(),
                const SizedBox(height: 20),
              ],
              
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
        color: Color(0xFFFFCC33),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Yatt's Kitchen",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black, height: 1.0)),
                  Text("Pavilion Unimas", style: TextStyle(fontSize: 18, color: Colors.black54)),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2)),
                  ],
                ),
                child: const Icon(Icons.notifications_none, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2)),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search Delicious Food',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow() {
    final List<Map<String, dynamic>> categories = [
      {'label': 'All', 'color': const Color(0xFF6B48FF), 'icon': '🍴'},
      {'label': 'Rice', 'color': const Color(0xFFE57373), 'icon': '🍚'},
      {'label': 'Noodles', 'color': const Color(0xFFFFA726), 'icon': '🍜'},
      {'label': 'Sides', 'color': const Color(0xFF4DB6AC), 'icon': '🍟'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categories.map((cat) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = cat['label']; 
              _searchQuery = ''; // Clear search when a category is tapped
            });
          },
          child: CategoryButton(
            label: cat['label'],
            icon: cat['icon'],
            backgroundColor: cat['color'],
            isSelected: _selectedCategory == cat['label'] && _searchQuery.isEmpty, 
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPopularHeader() {
    return Row(
      children: const [
        Icon(Icons.trending_up, color: Colors.red, size: 28),
        SizedBox(width: 8),
        Text(
          "Popular Today",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
  
  Widget _buildSearchHeader() {
    return Row(
      children: [
        Icon(Icons.search, color: Theme.of(context).primaryColor, size: 28),
        const SizedBox(width: 8),
        const Text(
          "Search Results",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
  
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Color(0xFFFFCC33)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyCartPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.watch_later_outlined, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFoodGrid(BuildContext context) {
    final filteredItems = _filteredFoodItems;

    if (_searchQuery.isNotEmpty && filteredItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            "No results found for '$_searchQuery'",
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 16.0) / 2;

        return Wrap(
          spacing: 16.0, 
          runSpacing: 16.0, 
          children: filteredItems.map((item) {
            return SizedBox(
              width: itemWidth, 
              child: PopularFoodCard(
                item: item, 
              ),
            );
          }).toList(),
        );
      },
    );
  }
}