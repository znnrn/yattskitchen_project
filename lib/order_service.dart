import 'package:flutter/material.dart';
import 'cart_service.dart';

enum OrderStatus { pending, accepted, declined }

class FoodOrder {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime timestamp;
  OrderStatus status;

  FoodOrder({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.timestamp,
    this.status = OrderStatus.pending,
  });
}

class OrderService extends ChangeNotifier {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();
  static OrderService get instance => _instance;

  final List<FoodOrder> _orders = [];
  int _orderCounter = 26; // Starting example A026

  List<FoodOrder> get allOrders => _orders;
  
  // Filter for the 'New Order' button
  List<FoodOrder> get pendingOrders => 
      _orders.where((o) => o.status == OrderStatus.pending).toList();

  void placeOrder(List<CartItem> items, double total) {
    final newOrder = FoodOrder(
      id: 'A0${_orderCounter++}',
      items: List.from(items), // Copy the list
      totalAmount: total,
      timestamp: DateTime.now(),
    );
    _orders.add(newOrder);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index].status = newStatus;
      notifyListeners();
    }
  }
}