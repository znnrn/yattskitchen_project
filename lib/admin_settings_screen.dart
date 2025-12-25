import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EBDD), // Light cream background from dashboard
      body: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 40),
          // Profile Section
          Center(
            child: Column(
              children: [
                // Large Avatar Circle
                Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFCC99),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    size: 100,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Buttons Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                _settingsButton("View Profile", () {}),
                const SizedBox(height: 20),
                _settingsButton("Change Password", () {}),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(), // Consistent with dashboard
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 10, right: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF1C40F), Color(0xFFE67E22)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Column(
            children: [
              Text("Hello, Admin!",
                  style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 18)),
              SizedBox(height: 10),
              Text("Yatt's Kitchen",
                  style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
              Text("Pavilion Unimas",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _settingsButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF7E21), // Vibrant orange
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: 3, // Settings tab selected
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.tune), label: ""),
      ],
    );
  }
}