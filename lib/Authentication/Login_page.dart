import 'dart:math';
import 'package:flutter/material.dart';
import 'auth_logic.dart';
import '../screens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // making a object of authlogic class
  Appwrite_Auth authService = Appwrite_Auth();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    authService.Intialize();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomePage(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background design
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.green.shade50,
                ],
              ),
            ),
          ),

          // Decorative elements
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2E7D32).withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2E7D32).withOpacity(0.05),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                          iconSize: 24,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(height: 40),

                        // Title and subtitle
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'WELCOME BACK',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: Color(0xFF2E7D32),
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Login to Your Account',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Continue your journey of giving and making a difference',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Login form
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Email field
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey[600],
                                  ),
                                  hintText: 'Enter your email',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey[400],
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email_rounded,
                                    color: Color(0xFF2E7D32),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF2E7D32),
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              // Password field
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey[600],
                                  ),
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey[400],
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock_rounded,
                                    color: Color(0xFF2E7D32),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF2E7D32),
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Remember me & Forgot password
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = value ?? false;
                                        });
                                      },
                                      activeColor: const Color(0xFF2E7D32),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      // Forgot password functionality
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(50, 30),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2E7D32),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),

                              // Login button
                              SizedBox(
                                width: double.infinity,
                                height: 58,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2E7D32),
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor:
                                        Colors.grey.shade300,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 5,
                                    shadowColor: const Color(0xFF2E7D32)
                                        .withOpacity(0.3),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : const Text(
                                          'LOG IN',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // OR divider
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey[300],
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      'OR',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey[300],
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Social login buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildSocialButton(
                                    icon: Icons.g_mobiledata_rounded,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 20),
                                  _buildSocialButton(
                                    icon: Icons.facebook_rounded,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),

                              // Sign up link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigate to sign up page
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(50, 30),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      ' Sign Up',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2E7D32),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 30,
        color: color,
      ),
    );
  }
}
