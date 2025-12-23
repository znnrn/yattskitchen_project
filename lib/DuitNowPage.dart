import 'package:flutter/material.dart';
import 'cart_service.dart'; 

// Mock Service to simulate generating a QR Code data 
class PaymentService {
  static String generateDuitNowQrCode() {
    return 'https://duitnow.my/qr/mock_transaction_12345'; 
  }
}

class DuitNowPage extends StatelessWidget {
  const DuitNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the CartService singleton
    final cartService = CartService.instance;
    final totalAmount = cartService.totalAmount;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F0), 
      
      appBar: AppBar(
        toolbarHeight: 180,
        automaticallyImplyLeading: false, 
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: _buildHeader(context),
      ),
      
      body: Column(
        children: [
          // Order Summary
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            child: _buildOrderSummary(totalAmount),
          ),
          
          // Directly display the DuitNow QR Content
          const Expanded(
            child: _DuitNowQrContent(),
          ),
        ],
      ),
      
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // --- WIDGET BUILDERS ---

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              // Back Button
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // Notification Button
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications_none, color: Colors.black, size: 28),
                ),
                onPressed: () {},
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
            "DuitNow QR",
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
      margin: const EdgeInsets.only(top: 16.0), 
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
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
            onPressed: () {
               // Assuming the cart is the route before this page
               Navigator.pop(context); 
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
}

// --- QR CONTENT WIDGET (Fixed for Image.asset syntax error) ---

class _DuitNowQrContent extends StatelessWidget {
  const _DuitNowQrContent();

  @override
  Widget build(BuildContext context) {
    final qrData = PaymentService.generateDuitNowQrCode();
    
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView( 
        child: Column(
          children: [
            const Text(
              'Scan to Pay',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 15),
            
            Container(
              width: MediaQuery.of(context).size.width * 0.75, 
              height: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Center(
                // *** SYNTAX FIX APPLIED HERE: Clean Image.asset call with named 'fit' ***
                child: Image.asset(
                  // Ensure this path is correct based on your pubspec.yaml setup
                  'assets/duitnow.jpg', 
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            const Text(
              'Use your banking app to scan and confirm payment.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              'Transaction ID: ${qrData.split('/').last}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}