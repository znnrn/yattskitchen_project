import 'package:flutter/material.dart';
import 'order_service.dart';

class IncomingOrdersScreen extends StatelessWidget {
  const IncomingOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EBDD),
      appBar: AppBar(
        title: const Text("Incoming Orders", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF1C40F),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListenableBuilder(
        listenable: OrderService.instance,
        builder: (context, child) {
          final pendingOrders = OrderService.instance.pendingOrders;

          if (pendingOrders.isEmpty) {
            return const Center(child: Text("No new orders at the moment."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pendingOrders.length,
            itemBuilder: (context, index) => _buildOrderCard(pendingOrders[index], context),
          );
        },
      ),
    );
  }

  Widget _buildOrderCard(FoodOrder order, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order.id, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // Queue Number
                    Text("${order.timestamp.hour}:${order.timestamp.minute.toString().padLeft(2, '0')} AM", 
                         style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const Divider(),
                const Text("ITEMS :", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text("• ${item.name}", style: const TextStyle(fontSize: 16)),
                )),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text("Take Away", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                Text("Total Amount :", style: TextStyle(color: Colors.grey.shade600)),
                Text("RM ${order.totalAmount.toStringAsFixed(2)}", 
                     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => OrderService.instance.updateOrderStatus(order.id, OrderStatus.accepted),
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2ECC71),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                    ),
                    child: const Center(child: Text("Accept", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => OrderService.instance.updateOrderStatus(order.id, OrderStatus.declined),
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE74C3C),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                    ),
                    child: const Center(child: Text("Decline", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}