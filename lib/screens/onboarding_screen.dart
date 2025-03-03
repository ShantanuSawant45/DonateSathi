import 'dart:math';
import 'package:flutter/material.dart';

import 'landing_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _particleController;
  late List<AnimationController> _iconControllers;
  late List<AnimationController> _textControllers;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.volunteer_activism,
      title: 'Donate Easily',
      description: 'Make a difference with just a few taps. Support causes you care about anytime, anywhere.',
    ),
    OnboardingPage(
      icon: Icons.track_changes,
      title: 'Track Your Impact',
      description: 'See exactly how your donations are making a difference with real-time impact tracking.',
    ),
    OnboardingPage(
      icon: Icons.people_alt_rounded,
      title: 'Join the Community',
      description: 'Connect with like-minded people and amplify your impact through collaborative giving.',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _particleController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _iconControllers = List.generate(
      _pages.length,
          (index) => AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      )..repeat(reverse: true),
    );

    _textControllers = List.generate(
      _pages.length,
          (index) => AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      )..forward(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _particleController.dispose();
    for (var controller in _iconControllers) {
      controller.dispose();
    }
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });

    // Reset and start animations for the new page
    _textControllers[page].reset();
    _textControllers[page].forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212), // Dark background
      body: Stack(
        children: [
          // Animated background particles
          CustomPaint(
            painter: ParticlePainter(_particleController),
            child: Container(),
          ),

          // Main content
          Column(
            children: [
              Expanded(
                flex: 4,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(index);
                  },
                ),
              ),

              // Page indicator and buttons
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Page indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                              (index) => _buildPageIndicator(index),
                        ),
                      ),
                      SizedBox(height: 40),

                      // Navigation buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Skip button
                          TextButton(
                            onPressed: () {
                              // Navigate to main app
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => AuthLandingPage()));
                            },
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                            ),
                          ),

                          // Next/Get Started button
                          ElevatedButton(
                            onPressed: () {
                              if (_currentPage == _pages.length - 1) {
                                // Navigate to main app on last page
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => AuthLandingPage()));
                              } else {
                                // Go to next page
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple[400],
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated icon
          AnimatedBuilder(
            animation: _iconControllers[index],
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + 0.1 * _iconControllers[index].value,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    _pages[index].icon,
                    size: 80,
                    color: Colors.purple[200],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 60),

          // Animated title
          FadeTransition(
            opacity: _textControllers[index],
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _textControllers[index],
                curve: Curves.easeOutCubic,
              )),
              child: Text(
                _pages[index].title,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.purple.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Animated description
          FadeTransition(
            opacity: _textControllers[index],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                _pages[index].description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    bool isActive = index == _currentPage;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.purple[400] : Colors.grey[600],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class ParticlePainter extends CustomPainter {
  final Animation<double> animation;
  final List<Particle> particles;

  ParticlePainter(this.animation) : particles = List.generate(50, (_) => Particle()) {
    animation.addListener(() {
      for (var particle in particles) {
        particle.update();
      }
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.purple[200]!.withOpacity(0.6);

    for (var particle in particles) {
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Particle {
  double x = Random().nextDouble();
  double y = Random().nextDouble();
  double speedX = Random().nextDouble() * 0.01 - 0.005;
  double speedY = Random().nextDouble() * 0.01 - 0.005;
  double radius = Random().nextDouble() * 2 + 1;

  void update() {
    x += speedX;
    y += speedY;

    if (x < 0 || x > 1) {
      speedX *= -1;
    }
    if (y < 0 || y > 1) {
      speedY *= -1;
    }
  }
}

// Usage:
// void main() {
//   runApp(MaterialApp(
//     home: OnboardingScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }