import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_project/screens/landing_page.dart';

import 'home_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _backgroundController;
  late AnimationController _contentController;
  int _currentPage = 0;
  bool _isLastPage = false;
  List<Color> _backgroundColors = [
    const Color(0xFFE8F5E9),
    const Color(0xFFE0F7FA),
    const Color(0xFFF1F8E9),
  ];

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Share with Purpose",
      subtitle: "Give Back, Move Forward",
      description:
          "Transform lives by sharing what you no longer need. Your unused items can become someone's essential resources.",
      icon: Icons.favorite_border_rounded,
      illustrationAsset: "", // You'll provide this later
    ),
    OnboardingContent(
      title: "Connect & Contribute",
      subtitle: "Be the Bridge",
      description:
          "Bridge the gap between donors and those in need. Make a direct impact in your community.",
      icon: Icons.handshake_outlined,
      illustrationAsset: "", // You'll provide this later
    ),
    OnboardingContent(
      title: "Track Your Impact",
      subtitle: "See the Difference",
      description:
          "See how your donations make a difference. Every contribution counts towards building a better tomorrow.",
      icon: Icons.track_changes_outlined,
      illustrationAsset: "", // You'll provide this later
    ),
  ];

  @override
  void initState() {
    super.initState();

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _backgroundController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _backgroundColors[_currentPage],
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const AuthLandingPage(),
                            transitionDuration:
                                const Duration(milliseconds: 800),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      // Reset animation controllers
                      _contentController.reset();
                      _contentController.forward();

                      _isLastPage = index == _contents.length - 1;
                      _currentPage = index;
                    });
                  },
                  itemCount: _contents.length,
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      content: _contents[index],
                      contentController: _contentController,
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // Page indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _contents.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 8),
                            height: 8,
                            width: _currentPage == index ? 32 : 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: _currentPage == index
                                  ? const Color(0xFF2E7D32)
                                  : Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Next/Get Started button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _isLastPage ? 200 : 70,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_isLastPage) {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      const AuthLandingPage(),
                                  transitionDuration:
                                      const Duration(milliseconds: 800),
                                  transitionsBuilder:
                                      (_, animation, __, child) {
                                    return FadeTransition(
                                        opacity: animation, child: child);
                                  },
                                ),
                              );
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shadowColor:
                                const Color(0xFF2E7D32).withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: _isLastPage
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "GET STARTED",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward_rounded),
                                  ],
                                )
                              : const Icon(Icons.arrow_forward_rounded,
                                  size: 28),
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
    );
  }
}

class OnboardingContent {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final String illustrationAsset;

  OnboardingContent({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.illustrationAsset,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;
  final AnimationController contentController;

  const OnboardingPage({
    Key? key,
    required this.content,
    required this.contentController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: contentController,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
          ),
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.2),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: contentController,
              curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Illustration placeholder
              Container(
                width: 300,
                height: 280,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    content.icon,
                    size: 100,
                    color: const Color(0xFF2E7D32).withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Subtitle
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  content.subtitle.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Title
              Text(
                content.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Color(0xFF2E7D32),
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                content.description,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: Colors.grey[700],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final Animation<double> animation;
  final List<Particle> particles;

  ParticlePainter(this.animation)
      : particles = List.generate(50, (_) => Particle()) {
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