import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oto_grid/features/auth/presentation/login_screen.dart';
import 'package:oto_grid/features/map/presentation/customer_map_screen.dart';
import 'package:oto_grid/features/triage/presentation/mechanic_dashboard_screen.dart';

/// Provider global untuk [GoRouter] agar dapat diinjeksi dan didengarkan status autentikasinya.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/customer',
        builder: (context, state) => const CustomerMapScreen(),
      ),
      GoRoute(
        path: '/mechanic',
        builder: (context, state) => const MechanicDashboardScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Halaman tidak ditemukan: ${state.error}'),
      ),
    ),
  );
});
