import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/services/model_service.dart';
import '../../../core/services/maintenance_service.dart';
import '../../auth/pages/auth_gate.dart';
import '../../maintenance/pages/maintenance_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Load models in the background
    ModelService.instance.loadModels();

    // Check maintenance status
    final maintenanceInfo = await MaintenanceService.checkMaintenanceStatus();

    // Keep splash visible for a moment
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      // Check if maintenance mode is active
      if (maintenanceInfo != null && maintenanceInfo.isMaintenanceMode) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => MaintenancePage(
              maintenanceInfo: maintenanceInfo,
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      } else {
        // No maintenance, proceed normally
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const AuthGate(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use Theme.of(context) to ensure the splash screen respects the MaterialApp's theme.
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'AhamAI',
                style: GoogleFonts.inter(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}