import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oto_grid/core/router/app_router.dart';
import 'package:oto_grid/core/theme/app_theme.dart';

void main() async {
  // Pastikan binding Flutter diinisialisasi sebelum proses asinkron
  WidgetsFlutterBinding.ensureInitialized();

  // Memuat file environment (.env)
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Peringatan: Gagal memuat file .env: $e");
  }

  runApp(
    // Mengaktifkan Riverpod State Management di root aplikasi
    const ProviderScope(
      child: OtoGridApp(),
    ),
  );
}

class OtoGridApp extends ConsumerWidget {
  const OtoGridApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'OtoGrid',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
