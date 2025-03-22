import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _particleController;
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _particleController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E17), // Dark background
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF151C28), Color(0xFF0A0E17)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.volunteer_activism,
              size: 30,
              color: Color(0xFF4ECDC4), // Teal accent
            ),
            SizedBox(width: 10),
            Text(
              'Donate Sathi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.white70),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background particles
          CustomPaint(
            painter: ParticlePainter(_particleController),
            child: Container(),
          ),

          // Futuristic grid lines
          CustomPaint(
            painter: GridPainter(),
            child: Container(),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Welcome card
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1A2233), Color(0xFF0F1620)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF4ECDC4).withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Welcome to Donate Sathi',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFF4ECDC4).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.trending_up,
                                color: Color(0xFF4ECDC4),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Your contribution creates meaningful impact',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4ECDC4),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              child: Text(
                                'DONATE NOW',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'LEARN MORE',
                                style: TextStyle(
                                  color: Color(0xFF4ECDC4),
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Tab Bar
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A2233),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFF4ECDC4).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child:TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4ECDC4), Color(0xFF00E676)], // Gradient for selected tab
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF4ECDC4).withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    labelColor: Colors.black, // Text color for selected tab
                    unselectedLabelColor: Colors.white70, // Text color for unselected tabs
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 14,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 14,
                    ),
                    tabs: [
                      Tab(
                        icon: Icon(Icons.volunteer_activism, size: 20), // Icon for Donate Items
                        text: 'DONATE ITEMS',
                      ),
                      Tab(
                        icon: Icon(Icons.local_shipping, size: 20), // Icon for NGO Pickup
                        text: 'NGO PICKUP',
                      ),
                    ],
                  ),
                ),

                // Tab Bar View
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Donate Items Tab
                      DonateItemsTab(),

                      // NGO Pickup Tab
                      NGOPickupTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF151C28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF4ECDC4),
          unselectedItemColor: Colors.white54,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism_outlined),
              activeIcon: Icon(Icons.volunteer_activism),
              label: 'Donate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              activeIcon: Icon(Icons.analytics),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

// Grid Painter for futuristic background
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF4ECDC4).withOpacity(0.05)
      ..strokeWidth = 0.5;

    // Horizontal lines
    double spacing = 30;
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Donation Items Tab
class DonateItemsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 4,
                decoration: BoxDecoration(
                  color: Color(0xFF4ECDC4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'DONATION CATEGORIES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Categories Grid
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.2,
            children: [
              _buildCategoryCard('CLOTHES', Icons.checkroom, context),
              _buildCategoryCard('BOOKS', Icons.menu_book, context),
              _buildCategoryCard('FOOD', Icons.fastfood, context),
              _buildCategoryCard('TOYS', Icons.toys, context),
              _buildCategoryCard('ELECTRONICS', Icons.devices, context),
              _buildCategoryCard('OTHERS', Icons.more_horiz, context),
            ],
          ),

          SizedBox(height: 24),

          Row(
            children: [
              Container(
                height: 24,
                width: 4,
                decoration: BoxDecoration(
                  color: Color(0xFF4ECDC4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'RECENT ACTIVITIES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Recent donations list
          _buildRecentDonationCard(
            'School Books',
            'Delivered to Education NGO',
            Icons.menu_book,
            '2d ago',
          ),
          _buildRecentDonationCard(
            'Winter Clothes',
            'Picked up by Helping Hands',
            Icons.checkroom,
            '7d ago',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1A2233),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFF4ECDC4).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF4ECDC4).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: Color(0xFF4ECDC4),
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentDonationCard(
      String title,
      String subtitle,
      IconData icon,
      String timeAgo,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1A2233),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF4ECDC4).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF4ECDC4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Color(0xFF4ECDC4),
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFF4ECDC4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              timeAgo,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF4ECDC4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// NGO Pickup Tab
class NGOPickupTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 4,
                decoration: BoxDecoration(
                  color: Color(0xFF4ECDC4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'AVAILABLE DONATIONS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'NGOs can view and select donations for distribution',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 16),

          // Donation Cards
          _buildDonationCard(
            'Winter Clothes',
            'Warm jackets, sweaters and gloves',
            '2.5 km',
            Icons.checkroom,
          ),
          _buildDonationCard(
            'School Supplies',
            'Notebooks, pens and backpacks',
            '3.8 km',
            Icons.school,
          ),
          _buildDonationCard(
            'Food Packages',
            'Dry rations and canned goods',
            '1.2 km',
            Icons.fastfood,
          ),

          SizedBox(height: 24),

          Row(
            children: [
              Container(
                height: 24,
                width: 4,
                decoration: BoxDecoration(
                  color: Color(0xFF4ECDC4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'SCHEDULED PICKUPS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Scheduled pickups
          _buildScheduledPickupCard(
            'Books and Stationery',
            'Tomorrow, 10:00 AM',
            '5.1 km',
            Icons.menu_book,
          ),
        ],
      ),
    );
  }

  Widget _buildDonationCard(
      String title,
      String description,
      String distance,
      IconData icon,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1A2233),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF4ECDC4).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
          children: [
      Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF4ECDC4).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: Color(0xFF4ECDC4),
        size: 24,
      ),
    ),
    SizedBox(width: 16),
    Expanded(
      // ... existing code ...
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF4ECDC4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                distance,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF4ECDC4),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
      ),
      ),
            Divider(
              color: Color(0xFF4ECDC4).withOpacity(0.1),
              thickness: 1,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF4ECDC4),
                        side: BorderSide(color: Color(0xFF4ECDC4), width: 1),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'VIEW DETAILS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4ECDC4),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'PICK UP',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
      ),
    );
  }

  Widget _buildScheduledPickupCard(
      String title,
      String time,
      String distance,
      IconData icon,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1A2233),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF4ECDC4).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF4ECDC4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Color(0xFF4ECDC4),
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF4ECDC4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    distance,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4ECDC4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4ECDC4),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'TRACK',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Particle Painter for animated background
class ParticlePainter extends CustomPainter {
  final Animation<double> animation;
  final List<Particle> particles = List.generate(
    50,
        (index) => Particle(
      position: Offset(
        Random().nextDouble() * 400,
        Random().nextDouble() * 800,
      ),
      radius: Random().nextDouble() * 2 + 1,
      color: Color(0xFF4ECDC4).withOpacity(Random().nextDouble() * 0.2),
      speed: Random().nextDouble() * 1.5 + 0.5,
    ),
  );

  ParticlePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      // Move particles upward
      particle.position = Offset(
        particle.position.dx,
        (particle.position.dy - particle.speed * animation.value) % size.height,
      );

      // Draw the particle
      final paint = Paint()..color = particle.color;
      canvas.drawCircle(particle.position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

// Particle class for the animated background
class Particle {
  Offset position;
  final double radius;
  final Color color;
  final double speed;

  Particle({
    required this.position,
    required this.radius,
    required this.color,
    required this.speed,
  });
}
