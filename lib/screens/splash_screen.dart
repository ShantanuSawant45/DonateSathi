import 'dart:math';
import 'package:flutter/material.dart';

import 'landing_page.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _particleController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 1000),
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212), // Dark background
      body: Stack(
        children: [
          CustomPaint(
            painter: ParticlePainter(_particleController),
            child: Container(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + 0.1 * _logoController.value,
                      child: Container(
                        width: 120,
                        height: 120,
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
                          Icons.volunteer_activism,
                          size: 80,
                          color: Colors.purple[200],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                FadeTransition(
                  opacity: _textController,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _textController,
                      curve: Curves.easeOutCubic,
                    )),
                    child: Text(
                      'Donate Sathi',
                      style: TextStyle(
                        fontSize: 40,
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
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: _textController,
                  child: Text(
                    'The Future of Giving',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CustomPaint(
                    painter: LoadingIndicatorPainter(_logoController),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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