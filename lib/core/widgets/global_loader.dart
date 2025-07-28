import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constant/colors.dart';

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

class GlobalLoaderOverlay extends StatelessWidget {
  const GlobalLoaderOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([GlobalLoader.of(context)]),
      builder: (context, child) {
        final loading = GlobalLoader.of(context).loading;
        if (!loading) return const SizedBox.shrink();

        return Stack(
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
            // Centered Animated Loader Card
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white.withOpacity(0.35), Colors.white.withOpacity(0.15)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
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
          ],
        );
      },
    );
  }
}


class GlobalLoader extends InheritedNotifier<GlobalLoaderProvider> {
  const GlobalLoader({super.key, required GlobalLoaderProvider notifier, required Widget child}) : super(notifier: notifier, child: child);

  static GlobalLoaderProvider of(BuildContext context) {
    final loader = context.dependOnInheritedWidgetOfExactType<GlobalLoader>();
    assert(loader != null, 'No GlobalLoader found in context');
    return loader!.notifier!;
  }
}