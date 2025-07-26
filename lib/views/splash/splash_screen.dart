import 'package:client_app/services/splash/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  SplashServices splashServices = SplashServices();
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _particleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _particleAnimation;
  
  bool _showContent = false;
  bool _showLogo = false;
  bool _showText = false;
  bool _lottieLoaded = false;

  // Particle system
  final List<_Particle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeParticles();
    _startAnimationSequence();
    splashServices.isLogin(context);
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.elasticOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.linear,
    ));

    // Start pulse animation
    _pulseController.repeat(reverse: true);
    _particleController.repeat();
  }

  void _initializeParticles() {
    for (int i = 0; i < 20; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble() * 400,
        y: _random.nextDouble() * 800,
        size: _random.nextDouble() * 4 + 1,
        speed: _random.nextDouble() * 2 + 0.5,
        opacity: _random.nextDouble() * 0.5 + 0.1,
      ));
    }
  }

  void _startAnimationSequence() async {
    // Start logo animation
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _showLogo = true;
    });
    _logoController.forward();

    // Start fade animation
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _showContent = true;
    });
    _fadeController.forward();

    // Show text
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _showText = true;
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  Widget _buildLogoWidget() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
                  BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
        ],
      ),
      child: _showLogo
          ? _lottieLoaded
              ? Lottie.asset(
                  'assets/animations/finance_loading.json',
                  controller: _logoController,
                  onLoaded: (composition) {
                    _logoController.duration = composition.duration;
                    setState(() {
                      _lottieLoaded = true;
                    });
                  },
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildFallbackLogo();
                  },
                )
              : _buildFallbackLogo()
          : const Icon(
              Icons.account_balance,
              size: 60,
              color: Color(0xFF3ac5c9),
            ),
    );
  }

  Widget _buildFallbackLogo() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: const Icon(
            Icons.account_balance,
            size: 60,
            color: Color(0xFF3ac5c9),
          ),
        );
      },
    );
  }

  Widget _buildParticles() {
    return AnimatedBuilder(
      animation: _particleAnimation,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: _ParticlePainter(
            particles: _particles,
            animation: _particleAnimation.value,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF3ac5c9),
                  Color(0xFF7b60c4),
                  Color(0xFF58458c),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
          
          // Floating particles
          _buildParticles(),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: _showContent ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1000),
                      child: AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Logo Container with shadow
                                _buildLogoWidget(),
                                const SizedBox(height: 30),
                                
                                // App Name with animated text
                                AnimatedOpacity(
                                  opacity: _showText ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 800),
                                  child: const Text(
                                    'Finance App',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(height: 10),
                                
                                // Tagline
                                AnimatedOpacity(
                                  opacity: _showText ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 800),
                                  child: const Text(
                                    'Your Financial Journey Starts Here',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                
                // Bottom section with loading indicator
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: _showText ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 800),
                        child: Container(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white.withValues(alpha: 0.8),
        ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedOpacity(
                        opacity: _showText ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 800),
                        child: const Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                    ],
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

class _Particle {
  double x;
  double y;
  final double size;
  final double speed;
  final double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double animation;

  _ParticlePainter({
    required this.particles,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      // Update particle position
      particle.y -= particle.speed;
      if (particle.y < -10) {
        particle.y = size.height + 10;
        particle.x = math.Random().nextDouble() * size.width;
      }

      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
