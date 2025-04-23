import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/ngo.dart';
import 'dart:math';

class NGODetailPage extends StatefulWidget {
  final NGO ngo;

  const NGODetailPage({Key? key, required this.ngo}) : super(key: key);

  @override
  _NGODetailPageState createState() => _NGODetailPageState();
}

class _NGODetailPageState extends State<NGODetailPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _amountController = TextEditingController();
  String? _paymentMethod;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _amountController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _submitDonation() {
    if (_formKey.currentState!.validate()) {
      // In a real app, process payment here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Processing donation of ₹${_amountController.text} to ${widget.ngo.name}',
          ),
          backgroundColor: const Color(0xFF6A11CB),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
          elevation: 6,
        ),
      );

      // Reset form
      _nameController.clear();
      _emailController.clear();
      _amountController.clear();
      setState(() {
        _paymentMethod = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Header with Image
                Stack(
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/ngoimage.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    // NGO Info overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cause badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF6A11CB),
                                    Color(0xFF2575FC)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.ngo.cause,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.ngo.name,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black54,
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.ngo.location,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black54,
                                        offset: Offset(0, 1),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        "4.8",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
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

                // Quick Action Buttons
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQuickAction(
                          icon: Icons.phone, label: 'Call', onTap: () {}),
                      _buildQuickAction(
                          icon: Icons.email, label: 'Email', onTap: () {}),
                      _buildQuickAction(
                          icon: Icons.public, label: 'Website', onTap: () {}),
                      _buildQuickAction(
                          icon: Icons.directions,
                          label: 'Directions',
                          onTap: () {}),
                    ],
                  ),
                ),

                // Main Content
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // About section
                      _buildSectionTitle('About'),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(20),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.ngo.description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Gallery preview
                            const Text(
                              'Gallery',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/ngoimage.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Contact Info
                      _buildSectionTitle('Contact Information'),
                      const SizedBox(height: 16),

                      // Contact Card
                      Container(
                        padding: const EdgeInsets.all(20),
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
                          children: [
                            // Phone
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF6A11CB),
                                        Color(0xFF2575FC)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Phone',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      widget.ngo.contactPhone,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),

                            // Email
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF6A11CB),
                                        Color(0xFF2575FC)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      widget.ngo.contactEmail,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Donation Form
                      _buildSectionTitle('Make a Donation'),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.all(20),
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Pre-defined amounts
                              const Text(
                                'Choose Amount',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildAmountButton('₹100'),
                                  _buildAmountButton('₹500'),
                                  _buildAmountButton('₹1000'),
                                  _buildAmountButton('₹5000'),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Name Field
                              _buildFormField(
                                controller: _nameController,
                                label: 'Full Name',
                                icon: Icons.person,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Email Field
                              _buildFormField(
                                controller: _emailController,
                                label: 'Email',
                                icon: Icons.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Amount Field
                              _buildFormField(
                                controller: _amountController,
                                label: 'Amount (₹)',
                                icon: Icons.currency_rupee,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an amount';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  if (int.parse(value) < 10) {
                                    return 'Minimum donation is ₹10';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),

                              // Payment Method
                              const Text(
                                'Payment Method',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Payment Options
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    _buildPaymentOption(
                                      title: 'Credit/Debit Card',
                                      value: 'card',
                                      icon: Icons.credit_card,
                                    ),
                                    Divider(
                                        height: 1, color: Colors.grey.shade200),
                                    _buildPaymentOption(
                                      title: 'UPI',
                                      value: 'upi',
                                      icon: Icons.account_balance_wallet,
                                    ),
                                    Divider(
                                        height: 1, color: Colors.grey.shade200),
                                    _buildPaymentOption(
                                      title: 'Net Banking',
                                      value: 'netbanking',
                                      icon: Icons.account_balance,
                                    ),
                                    Divider(
                                        height: 1, color: Colors.grey.shade200),
                                    _buildPaymentOption(
                                      title: 'PayPal',
                                      value: 'paypal',
                                      icon: Icons.payment,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Submit Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _submitDonation,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color(0xFF6A11CB),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'MAKE DONATION',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountButton(String amount) {
    return InkWell(
      onTap: () {
        _amountController.text = amount.replaceAll('₹', '');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF6A11CB).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          amount,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A11CB),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF6A11CB).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6A11CB),
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 5,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.grey[800]),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey[600],
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF6A11CB),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          errorStyle: TextStyle(
            color: Colors.red.shade700,
            fontSize: 12,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String value,
    required IconData icon,
  }) {
    final isSelected = _paymentMethod == value;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _paymentMethod = value;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFF6A11CB) : Colors.grey[600],
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isSelected ? const Color(0xFF6A11CB) : Colors.grey[800],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Spacer(),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF6A11CB)
                        : Colors.grey.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Container(
                        margin: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6A11CB),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4CAF50).withOpacity(0.05)
      ..strokeWidth = 0.5;

    double spacing = 40;

    // Horizontal lines
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

    // Draw some accent lines
    final accentPaint = Paint()
      ..color = const Color(0xFF4CAF50).withOpacity(0.1)
      ..strokeWidth = 1.5;

    // Horizontal accent lines
    for (double y = spacing * 3; y < size.height; y += spacing * 5) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        accentPaint,
      );
    }

    // Vertical accent lines
    for (double x = spacing * 2; x < size.width; x += spacing * 4) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        accentPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DetailParticlePainter extends CustomPainter {
  final List<Particle> particles = List.generate(
    60,
    (index) => Particle(
      position: Offset(
        Random().nextDouble() * 400,
        Random().nextDouble() * 800,
      ),
      radius: Random().nextDouble() * 3 + 0.5,
      color: Color.lerp(
        const Color(0xFF4CAF50),
        Colors.white,
        Random().nextDouble(),
      )!
          .withOpacity(Random().nextDouble() * 0.3),
    ),
  );

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()..color = particle.color;
      canvas.drawCircle(particle.position, particle.radius, paint);

      // Add glow effect for larger particles
      if (particle.radius > 1.5) {
        final glowPaint = Paint()
          ..color = particle.color.withOpacity(0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
        canvas.drawCircle(particle.position, particle.radius * 2, glowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Particle {
  final Offset position;
  final double radius;
  final Color color;

  Particle({
    required this.position,
    required this.radius,
    required this.color,
  });
}
