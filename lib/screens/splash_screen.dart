import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'landing_page.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _pulseAnimation =
        Tween<double>(begin: 1.0, end: 1.1).animate(_pulseController);
    _rotateAnimation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(_rotateController);

    _animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OnboardingScreen(),
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.green.shade50,
              Colors.green.shade100,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: Listenable.merge(
                    [_scaleAnimation, _pulseAnimation, _rotateAnimation]),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value * _pulseAnimation.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Rotating rings
                        Transform.rotate(
                          angle: _rotateAnimation.value,
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  const Color(0xFF2E7D32).withOpacity(0.0),
                                  const Color(0xFF2E7D32),
                                  const Color(0xFF2E7D32).withOpacity(0.0),
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                            ),
                          ),
                        ),
                        // Inner circle with shadow
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF2E7D32).withOpacity(0.2),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        // Logo icon
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF2E7D32),
                                const Color(0xFF388E3C),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.volunteer_activism,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    const Text(
                      'Donate Sathi',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color(0xFF2E7D32),
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Empowering Communities Together',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xFF424242),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
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

class LoadingIndicatorPainter extends CustomPainter {
  final Animation<double> animation;

  LoadingIndicatorPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * animation.value,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
