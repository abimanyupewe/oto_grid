import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oto_grid/core/theme/app_theme.dart';

/// [MechanicDashboardScreen] adalah layar utama mekanik untuk menerima pesanan dan kelola koin.
class MechanicDashboardScreen extends StatefulWidget {
  const MechanicDashboardScreen({super.key});

  @override
  State<MechanicDashboardScreen> createState() => _MechanicDashboardScreenState();
}

class _MechanicDashboardScreenState extends State<MechanicDashboardScreen> {
  bool _isOnline = false;
  int _coins = 50; // Koin awal simulasi

  void _toggleStatus() {
    setState(() {
      _isOnline = !_isOnline;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isOnline
            ? 'Status Anda sekarang ONLINE. Siap menerima pesanan.'
            : 'Status Anda sekarang OFFLINE.'),
        backgroundColor: _isOnline ? AppTheme.primaryColor : Colors.grey,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Mekanik'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Mekanik Info
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                  child: const Icon(Icons.engineering_rounded,
                      color: AppTheme.primaryColor, size: 32),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bengkel Jaya Motor',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.charcoalColor,
                        ),
                      ),
                      Text(
                        'Mekanik Terverifikasi (Malang)',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Bento Grid: Status & Koin
            Row(
              children: [
                // Status Box
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 140,
                    decoration: BoxDecoration(
                      color: _isOnline
                          ? AppTheme.primaryColor.withValues(alpha: 0.08)
                          : Colors.white,
                      border: Border.all(
                        color: _isOnline
                            ? AppTheme.primaryColor
                            : Colors.grey.shade200,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.power_settings_new_rounded,
                            color: AppTheme.charcoalColor),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Status Kerja',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _isOnline ? 'ONLINE' : 'OFFLINE',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _isOnline
                                    ? AppTheme.primaryColor
                                    : AppTheme.charcoalColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Coins Box (Pay-Per-Lead)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.monetization_on_outlined,
                            color: Colors.amber),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Saldo Koin',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$_coins Koin',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.charcoalColor,
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
            const SizedBox(height: 24),

            // Go Online Button
            ElevatedButton(
              onPressed: _toggleStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isOnline ? AppTheme.secondaryColor : AppTheme.primaryColor,
              ),
              child: Text(_isOnline ? 'TUTUP LAYANAN (OFFLINE)' : 'MULAI LAYANAN (ONLINE)'),
            ),
            const SizedBox(height: 32),

            // Section Job Requests
            const Text(
              'Pesanan Darurat Masuk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.charcoalColor,
              ),
            ),
            const SizedBox(height: 16),

            // Simulasi list pesanan kosong jika offline
            if (!_isOnline)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    children: [
                      Icon(Icons.radar_rounded, size: 48, color: Colors.grey.shade300),
                      const SizedBox(height: 12),
                      const Text(
                        'Ubah status menjadi ONLINE\nuntuk melihat bantuan terdekat',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              )
            else
              // Pesanan simulasi jika online
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Darurat - Ban Bocor',
                            style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Text(
                          '1.2 KM',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Triage AI: Ban belakang bocor parah setelah melindas paku besar di sekitar jl. Suhat.',
                      style: TextStyle(fontSize: 13, color: AppTheme.charcoalColor),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Tolak'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _coins -= 2; // Potong 2 koin per lead
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Pesanan diterima! Saldo terpotong 2 Koin.'),
                                  backgroundColor: AppTheme.primaryColor,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Terima (2 Koin)'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
