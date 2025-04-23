import 'package:flutter/material.dart';
import '../models/ngo.dart';
import 'ngo_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<NGO> _ngos;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _ngos = NGO.getDummyNGOs();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Donate Sathi',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6A11CB),
                      Color(0xFF2575FC),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.volunteer_activism,
                              size: 40,
                              color: Colors.white,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Make a difference today',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        _CategoryChip(label: 'All', isActive: true),
                        SizedBox(width: 8),
                        _CategoryChip(label: 'Education'),
                        SizedBox(width: 8),
                        _CategoryChip(label: 'Health'),
                        SizedBox(width: 8),
                        _CategoryChip(label: 'Environment'),
                        SizedBox(width: 8),
                        _CategoryChip(label: 'Animals'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Featured NGOs',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Support these organizations making an impact',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // NGO List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: _NGOCard(
                    ngo: _ngos[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NGODetailPage(ngo: _ngos[index]),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: _ngos.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                activeIcon: Icon(Icons.favorite),
                label: 'Donations',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xFF2575FC),
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF2575FC),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _CategoryChip({
    Key? key,
    required this.label,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF2575FC) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? Colors.transparent : Colors.grey.shade300,
        ),
        boxShadow: [
          if (!isActive)
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _NGOCard extends StatelessWidget {
  final NGO ngo;
  final VoidCallback onTap;

  const _NGOCard({
    Key? key,
    required this.ngo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // NGO Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  'assets/ngoimage.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // NGO Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2575FC).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          ngo.cause,
                          style: const TextStyle(
                            color: Color(0xFF2575FC),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.verified,
                        color: Color(0xFF2575FC),
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    ngo.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ngo.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Color(0xFF2575FC),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ngo.location,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2575FC),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Donate Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}