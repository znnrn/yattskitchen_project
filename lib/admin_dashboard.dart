import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EBDD), // Light cream background
      bottomNavigationBar: _buildBottomNav(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Status Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.4,
                    children: [
                      _buildStatCard("Today's Orders", "47", Icons.shopping_cart_outlined, const Color(0xFFF39C12), growth: "+12%"),
                      _buildStatCard("Orders Completed", "42", Icons.inventory_2_outlined, const Color(0xFF2ECC71)),
                      _buildStatCard("In Queue", "5", Icons.access_time, const Color(0xFF5D6D7E)),
                      _buildStatCard("Today's Revenue", "RM 300", Icons.attach_money, const Color(0xFF9B59B6)),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),

                  // 2. Quick Actions Grid
                  _buildQuickActions(),

                  const SizedBox(height: 24),
                  const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),

                  // 3. Activity List
                  _buildActivityList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Components ---

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF1C40F), Color(0xFFE67E22)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text("Hello, Admin!", style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 18)),
               Spacer(),
               Icon(Icons.notifications_none, color: Colors.white, size: 28),
            ],
          ),
          SizedBox(height: 10),
          Text("Yatt's Kitchen", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold)),
          Text("Pavilion Unimas", style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, {String? growth}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white70, size: 20),
              if (growth != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                  child: Text(growth, style: const TextStyle(color: Colors.white, fontSize: 10)),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: [
        _actionBtn("New Order", Icons.bakery_dining, Colors.orange),
        _actionBtn("Menu Items", Icons.restaurant_menu, Colors.grey.shade400),
        _actionBtn("Analytics", Icons.bar_chart, Colors.grey.shade400),
        _actionBtn("Settings", Icons.settings, Colors.grey.shade400),
      ],
    );
  }

  Widget _actionBtn(String label, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActivityList() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          _activityItem("Order #1247", "Completed & delivered", "2 min ago", Icons.check_circle, Colors.green),
          const Divider(height: 1),
          _activityItem("Order #1248", "New order received", "5 min ago", Icons.notifications_active, Colors.blue),
          const Divider(height: 1),
          _activityItem("Order #1249", "Ready for pickup", "8 min ago", Icons.access_time_filled, Colors.orange),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextButton(onPressed: () {}, child: const Text("View All →", style: TextStyle(color: Colors.orange))),
          )
        ],
      ),
    );
  }

  Widget _activityItem(String title, String sub, String time, IconData icon, Color color) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
      trailing: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.tune), label: ""),
      ],
    );
  }
}