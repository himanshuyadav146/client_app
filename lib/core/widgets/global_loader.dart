import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GlobalLoaderProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  void show() {
    if (!_loading) {
      _loading = true;
      notifyListeners();
    }
  }

  void hide() {
    if (_loading) {
      _loading = false;
      notifyListeners();
    }
  }
}

class GlobalLoaderOverlay extends StatefulWidget {
  const GlobalLoaderOverlay({super.key});

  @override
  State<GlobalLoaderOverlay> createState() => _GlobalLoaderOverlayState();
}

class _GlobalLoaderOverlayState extends State<GlobalLoaderOverlay>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _particleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _particleAnimation;

  final List<_Particle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeParticles();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _particleController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.linear),
    );
  }

  void _initializeParticles() {
    final screenWidth =
        MediaQuery.of(context).size.width; // Use context cautiously
    final screenHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < 15; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble() * screenWidth,
        y: _random.nextDouble() * screenHeight,
        size: _random.nextDouble() * 3 + 1,
        speed: _random.nextDouble() * 1.5 + 0.5,
        opacity: _random.nextDouble() * 0.4 + 0.1,
      ));
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: GlobalLoader.of(context),
      builder: (context, child) {
        final loading = GlobalLoader.of(context).loading;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          if (loading) {
            _fadeController.forward();
            if (!_particleController.isAnimating) {
              _particleController.repeat();
            }
          } else {
            _fadeController.reverse();
            if (_particleController.isAnimating) {
              _particleController.stop();
            }
          }
        });

        if (!loading && _fadeController.isDismissed) {
          return const SizedBox.shrink();
        }

        return AnimatedBuilder(
          animation: Listenable.merge([_fadeController, _particleController]),
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Stack(
                children: [
                  // Blur + Semi-transparent background
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ),

                  // Particle animation
                  Positioned.fill(
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: _ParticlePainter(
                        particles: _particles,
                        animation: _particleAnimation.value,
                        random: _random,
                      ),
                    ),
                  ),

                  // Centered Animated Loader Card
                  Center(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.35),
                              Colors.white.withOpacity(0.15)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.2)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Ring shimmer animation
                            Positioned.fill(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.15),
                                    width: 4,
                                  ),
                                ),
                              ),
                            ),
                            // Lottie animation
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Lottie.asset(
                                'assets/animations/finance_loading.json',
                                repeat: true,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class GlobalLoader extends InheritedNotifier<GlobalLoaderProvider> {
  const GlobalLoader(
      {super.key, required GlobalLoaderProvider notifier, required Widget child})
      : super(notifier: notifier, child: child);

  static GlobalLoaderProvider of(BuildContext context) {
    final loader = context.dependOnInheritedWidgetOfExactType<GlobalLoader>();
    assert(loader != null, 'No GlobalLoader found in context');
    return loader!.notifier!;
  }
}

// --- Particle System ---

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
  final math.Random random;

  _ParticlePainter({
    required this.particles,
    required this.animation,
    required this.random,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      // Update particle position
      particle.y -= particle.speed;
      if (particle.y < -10) {
        particle.y = size.height + 10;
        particle.x = random.nextDouble() * size.width;
      }

      final a = (particle.opacity * 255).round();
      paint.color = Colors.white.withAlpha(a);

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