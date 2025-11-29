import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../repositories/user_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Job Seeker'; // Default role

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      // Save user info and selected role
      bool success = await UserRepository.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _selectedRole,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );

        // Navigate back to login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error creating account. Try again.')),
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
            child: Column(
              children: [
                const Icon(Icons.person_add, color: Colors.teal, size: 80),
                const SizedBox(height: 20),
                const Text(
                  'Create Your Gig Connect Account',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email input
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (v) =>
                        v!.isEmpty ? 'Please enter your email' : null,
                      ),
                      const SizedBox(height: 15),

                      // Password input
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (v) =>
                        v!.length < 6 ? 'Minimum 6 characters' : null,
                      ),
                      const SizedBox(height: 20),

                      // 🧍 Role selector
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: const InputDecoration(
                          labelText: 'Select Role',
                          prefixIcon: Icon(Icons.work_outline),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Job Seeker',
                            child: Text('Job Seeker'),
                          ),
                          DropdownMenuItem(
                            value: 'Job Poster',
                            child: Text('Job Poster'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 25),

                      // Submit button
                      ElevatedButton(
                        onPressed: _signup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
