import 'package:flutter/material.dart';
import 'cart_service.dart'; 
import 'DuitNowPage.dart'; // Destination page for DuitNow QR

// --- MAIN PAYMENT OPTIONS WIDGET ---

class PaymentOptionsPage extends StatelessWidget {
  const PaymentOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the CartService singleton (assuming the cart service is available)
    // If not, mock the total amount
    final cartService = CartService.instance;
    final totalAmount = cartService.totalAmount;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F0), 
      
      appBar: AppBar(
        toolbarHeight: 180,
        // Since we are building a custom header in flexibleSpace, we disable the default back button
        automaticallyImplyLeading: false, 
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Pass context to the custom header builder
        flexibleSpace: _buildHeader(context), 
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Card
            _buildOrderSummary(totalAmount),
            const SizedBox(height: 20),
            
            // --- PAYMENT OPTIONS ---
            
            // 1. Cash at Counter
            _buildPaymentOption(
              context,
              icon: Icons.wallet,
              iconColor: Colors.green,
              title: 'Cash at Counter',
              subtitle: 'Pay when you collect',
              onTap: () {
                // Mock logic for Cash at Counter confirmation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cash at Counter selected. Proceeding to order confirmation.')),
                );
              },
            ),
            const SizedBox(height: 15),
            
            // 2. DuitNow QR
            _buildPaymentOption(
              context,
              icon: Icons.qr_code_scanner,
              iconColor: Colors.blue,
              title: 'DuitNow QR',
              subtitle: 'Scan to pay instantly',
              onTap: () {
                // NAVIGATION: Go to DuitNowPage (QR Code screen)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DuitNowPage()),
                );
              },
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- WIDGET BUILDERS ---
  
  // *** UPDATED: Now accepts context and includes a back button ***
  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFCC33), Color(0xFFFF9900)], 
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
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
            // Use spaceBetween to place Back and Notifications icons on opposite sides
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. Back Button (NEW)
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  // Icon must be visible
                  child: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                ),
                onPressed: () {
                  // Navigates back to MyCartPage
                  Navigator.pop(context);
                },
              ),
              // 2. Notification Button
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
            "Payment Method",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.0,
            ),
          ),
          const Text(
            "Choose how to pay",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(double total) {
    const serviceCharge = 0.00; 

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 20),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal:', style: TextStyle(fontSize: 16)),
              Text('RM ${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Service Charge:', style: TextStyle(fontSize: 16)),
              Text('RM ${serviceCharge.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            ],
          ),
          
          const Divider(height: 30, thickness: 1.5, color: Colors.grey),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                'RM ${(total + serviceCharge).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 30),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
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
            icon: const Icon(Icons.home, color: Colors.grey), 
            onPressed: () {},
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