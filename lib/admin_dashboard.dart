import 'package:flutter/material.dart';
import 'incoming_orders_screen.dart'; 
import 'admin_settings_screen.dart'; 

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EBDD),
      bottomNavigationBar: _buildBottomNav(context),
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

                  // 2. Quick Actions Grid with Hovering Capability
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5,
                    children: [
                      HoverActionBtn(
                        label: "New Order", 
                        icon: Icons.bakery_dining, 
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const IncomingOrdersScreen())),
                      ),
                      HoverActionBtn(
                        label: "Menu Items", 
                        icon: Icons.restaurant_menu, 
                        onTap: () { /* Add navigation here */ },
                      ),
                      HoverActionBtn(
                        label: "Analytics", 
                        icon: Icons.bar_chart, 
                        onTap: () { /* Add navigation here */ },
                      ),
                      HoverActionBtn(
                        label: "Settings", 
                        icon: Icons.settings, 
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminSettingsScreen())),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildActivityList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Header ---
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

  // --- Stats Cards ---
  Widget _buildStatCard(String title, String value, IconData icon, Color color, {String? growth}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Colors.white70, size: 20),
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

  // --- Recent Activity ---
  Widget _buildActivityList() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          _activityItem("Order #1247", "Completed", "2 min ago", Icons.check_circle, Colors.green),
          _activityItem("Order #1248", "New order", "5 min ago", Icons.notifications, Colors.blue),
        ],
      ),
    );
  }

  Widget _activityItem(String title, String sub, String time, IconData icon, Color color) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(sub),
      trailing: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 3) Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminSettingsScreen()));
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.tune), label: ""),
      ],
    );
  }
}

// --- THIS IS THE HOVER BUTTON THAT MAKES IT WORK ---
class HoverActionBtn extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const HoverActionBtn({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<HoverActionBtn> createState() => _HoverActionBtnState();
}

class _HoverActionBtnState extends State<HoverActionBtn> {
  bool _isPressed = false; // Changed from Hover to Pressed

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // When the user touches the button
      onTapDown: (_) => setState(() => _isPressed = true),
      // When the user lifts their finger
      onTapUp: (_) => setState(() => _isPressed = false),
      // If the user drags their finger away
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          // Logic: If touched/pressed, turn Orange. Otherwise, stay Grey.
          color: _isPressed ? const Color(0xFFFF7E21) : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(15),
          boxShadow: _isPressed 
              ? [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon, 
              color: _isPressed ? Colors.white : Colors.black54
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: TextStyle(
                color: _isPressed ? Colors.white : Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}