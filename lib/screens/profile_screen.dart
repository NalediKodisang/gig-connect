import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserRepository.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person, size: 80, color: Colors.green),
                const SizedBox(height: 20),
                Text(
                  user?.email ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  user?.role == 'poster'
                      ? 'Role: Job Poster '
                      : 'Role: Job Seeker ',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    UserRepository.currentUser = null;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                          (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Log Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 45),
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
