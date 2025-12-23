// my_cart_page.dart

import 'package:flutter/material.dart';
import 'cart_item_card.dart'; 
import 'cart_service.dart'; // Import the correct service
import 'PaymentOptionsPage.dart'; // Ensure this is imported for navigation

// Reuse the CartItem definition from cart_service.dart, remove local model.
// (Assuming CartItem model is now ONLY in cart_service.dart)

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  // *** Use the CartService singleton for state ***
  final CartService _cartService = CartService.instance;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the cart service to rebuild the UI
    _cartService.addListener(_onCartChange);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChange);
    super.dispose();
  }

  void _onCartChange() {
    // Force a rebuild when the cart items change in CartService
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<CartItem> cartItems = _cartService.items;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F0), 
      
      appBar: AppBar(
        toolbarHeight: 180, 
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: _buildHeader(cartItems.length), 
      ),
      
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty!", style: TextStyle(fontSize: 20, color: Colors.grey)))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: cartItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CartItemCard(
                      item: item,
                      onAdd: () => _cartService.updateQuantity(item, 1),
                      onSubtract: () => _cartService.updateQuantity(item, -1),
                      onRemove: () => _cartService.removeItem(item),
                    ),
                  );
                }).toList(),
              ),
            ),
      
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          if (cartItems.isNotEmpty) _buildTotalSummary(context),
          _buildBottomNavBar(context),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeader(int itemCount) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFCC33), 
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          colors: [Color(0xFFFFCC33), Color(0xFFFF9900)], 
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_none, color: Colors.black, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "My Cart",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.0,
            ),
          ),
          Text(
            "$itemCount items selected",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSummary(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFCC33),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "RM ${_cartService.totalAmount.toStringAsFixed(2)}", 
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to PaymentOptionsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentOptionsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFFF33), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Proceed to Payment',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
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
            icon: const Icon(Icons.home_outlined, color: Colors.grey),
            onPressed: () {
             Navigator.pop(context); 
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Color(0xFFFFCC33)), 
            onPressed: () {},
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
}