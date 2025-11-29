import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import '../repositories/user_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      bool success = await UserRepository.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (success) {
        final role = UserRepository.getCurrentUserRole();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(userRole: role ?? 'seeker'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(Icons.work_outline,
                      color: Color(0xFFFF9800), size: 90),
                  const SizedBox(height: 25),
                  const Text(
                    'Welcome to Gig Connect',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00897B)),
                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon:
                      const Icon(Icons.email, color: Color(0xFF00897B)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) =>
                    v!.isEmpty ? 'Please enter your email' : null,
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon:
                      const Icon(Icons.lock, color: Color(0xFF00897B)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) =>
                    v!.isEmpty ? 'Please enter your password' : null,
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9800),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Login'),
                  ),

                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Color(0xFF00897B)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
