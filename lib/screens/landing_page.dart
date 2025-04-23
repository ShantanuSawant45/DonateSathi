import 'dart:math';
import 'package:flutter/material.dart';
import 'package:web_project/Authentication/Login_page.dart';
import 'package:web_project/Authentication/signup_page.dart';
import 'home_page.dart';

class AuthLandingPage extends StatefulWidget {
  const AuthLandingPage({Key? key}) : super(key: key);

  @override
  _AuthLandingPageState createState() => _AuthLandingPageState();
}

class _AuthLandingPageState extends State<AuthLandingPage>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _iconController;
  late AnimationController _textController;
  late AnimationController _buttonController;

  late Animation<double> _backgroundAnimation;
  late Animation<double> _iconAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _buttonAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _iconController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _backgroundAnimation = CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeOut,
    );

    _iconAnimation = CurvedAnimation(
      parent: _iconController,
      curve: Curves.elasticOut,
    );

    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutQuad,
    );

    _buttonAnimation = CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeOutBack,
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations in sequence
    _backgroundController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _iconController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _textController.forward();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _iconController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.green.shade50.withOpacity(_backgroundAnimation.value),
                  Colors.green.shade100.withOpacity(_backgroundAnimation.value),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    // Title & Tagline
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.2),
                        end: Offset.zero,
                      ).animate(_textAnimation),
                      child: FadeTransition(
                        opacity: _textAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Welcome to\n',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF424242),
                                      height: 1.3,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Donate Sathi',
                                    style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF2E7D32),
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2E7D32).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: const Text(
                                'MAKE A DIFFERENCE TODAY',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF2E7D32),
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Illustration
                    Expanded(
                      child: Center(
                        child: ScaleTransition(
                          scale: _iconAnimation,
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Background decorative elements
                                Positioned(
                                  top: 30,
                                  right: 30,
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF2E7D32)
                                          .withOpacity(0.1),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 50,
                                  left: 40,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF2E7D32)
                                          .withOpacity(0.05),
                                    ),
                                  ),
                                ),

                                // Animated circles
                                AnimatedBuilder(
                                  animation: _rotateAnimation,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _rotateAnimation.value * 0.5,
                                      child: Container(
                                        width: 180,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF2E7D32)
                                                .withOpacity(0.2),
                                            width: 2,
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                // Animated circles 2
                                AnimatedBuilder(
                                  animation: _rotateAnimation,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: -_rotateAnimation.value * 0.3,
                                      child: Container(
                                        width: 220,
                                        height: 220,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF2E7D32)
                                                .withOpacity(0.1),
                                            width: 3,
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                // Main icon with shadow
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF2E7D32)
                                            .withOpacity(0.2),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.volunteer_activism,
                                    size: 50,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Buttons
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(_buttonAnimation),
                      child: FadeTransition(
                        opacity: _buttonAnimation,
                        child: Column(
                          children: [
                            // Login Button
                            Container(
                              height: 58,
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2E7D32),
                                    Color(0xFF388E3C)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2E7D32)
                                        .withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            const LoginPage(),
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        transitionsBuilder:
                                            (_, animation, __, child) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(1, 0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'LOGIN',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Sign Up Button
                            Container(
                              height: 58,
                              margin: const EdgeInsets.only(bottom: 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xFF2E7D32),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            const SignUpPage(),
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        transitionsBuilder:
                                            (_, animation, __, child) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(1, 0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  child: const Center(
                                    child: Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        color: Color(0xFF2E7D32),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
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
        },
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
