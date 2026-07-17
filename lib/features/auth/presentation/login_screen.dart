import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oto_grid/core/theme/app_theme.dart';

/// [LoginScreen] menyediakan antarmuka login yang bersih dengan opsi simulasi role.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'customer'; // Default role

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Simulasi login sukses dan penentuan routing berdasarkan role
    if (_selectedRole == 'customer') {
      context.go('/customer');
    } else {
      context.go('/mechanic');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              // Brand Logo / Icon Placeholder
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.grid_view_rounded,
                      color: AppTheme.primaryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'OtoGrid',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.charcoalColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Selamat Datang',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'Masuk ke akun Anda atau pilih simulasi role untuk testing cepat.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 32),

              // Email Input Card
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password Input Card
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),

              // Role Selection (Bento-like Toggle)
              Text(
                'Pilih Role (Simulasi MVP)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedRole = 'customer'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _selectedRole == 'customer'
                              ? AppTheme.primaryColor.withValues(alpha: 0.1)
                              : Colors.white,
                          border: Border.all(
                            color: _selectedRole == 'customer'
                                ? AppTheme.primaryColor
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: _selectedRole == 'customer'
                                  ? AppTheme.primaryColor
                                  : AppTheme.charcoalColor,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Customer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedRole == 'customer'
                                    ? AppTheme.primaryColor
                                    : AppTheme.charcoalColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedRole = 'mechanic'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _selectedRole == 'mechanic'
                              ? AppTheme.primaryColor.withValues(alpha: 0.1)
                              : Colors.white,
                          border: Border.all(
                            color: _selectedRole == 'mechanic'
                                ? AppTheme.primaryColor
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.build_outlined,
                              color: _selectedRole == 'mechanic'
                                  ? AppTheme.primaryColor
                                  : AppTheme.charcoalColor,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Mechanic',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _selectedRole == 'mechanic'
                                    ? AppTheme.primaryColor
                                    : AppTheme.charcoalColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Login CTA Button
              ElevatedButton(
                onPressed: _handleLogin,
                child: const Text('MASUK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
