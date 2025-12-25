// cart_service.dart

import 'package:flutter/foundation.dart'; 
import 'FoodMenuScreen.dart'; 

// --- CART ITEM MODEL ---
class CartItem {
  final String name;
  final double price;
  int quantity;
  final String imagePlaceholder;

  CartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.imagePlaceholder,
  });
}

// --- CART SERVICE SINGLETON ---
class CartService extends ChangeNotifier {
  // Singleton Setup
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();
  static CartService get instance => _instance;

  // State
  // *** INITIALIZING WITH AN EMPTY LIST ***
  final List<CartItem> _items = []; // Cart now starts empty.
  
  List<CartItem> get items => _items;

  // Logic: Total Calculation
  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
  
  void clearCart() {
    _items.clear(); // Clears the list of items in the cart
    notifyListeners(); // Tells the UI to refresh (so the cart shows 0 items)
  }

  // Logic: Add Item
  void addItem(FoodItem foodItem) {
    if (foodItem.price == null) return; 

    try {
      final existingItem = _items.firstWhere((item) => item.name == foodItem.name);
      existingItem.quantity += 1;
    } catch (e) {
      _items.add(
        CartItem(
          name: foodItem.name,
          price: double.tryParse(foodItem.price!) ?? 0.0, 
          quantity: 1,
          imagePlaceholder: _getPlaceholder(foodItem.category),
        ),
      );
    }
    notifyListeners(); 
  }

  // Logic: Quantity Updates
  void updateQuantity(CartItem item, int change) {
    item.quantity += change;
    if (item.quantity < 1) {
      removeItem(item);
      return; 
    }
    notifyListeners();
  }

  // Logic: Remove Item
  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }
  
  // Helper to get a simple emoji placeholder based on category
  String _getPlaceholder(String category) {
    switch(category) {
      case 'Rice': return '🍚';
      case 'Noodles': return '🍜';
      case 'Sides': return '🍟';
      default: return '🍴';
    }
  }
}