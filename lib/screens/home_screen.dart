import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import 'job_listings_screen.dart';
import 'post_job_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userRole;
  const HomeScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    final isPoster = userRole == 'poster';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Gig Connect',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF00897B),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.work_outline,
                color: Color(0xFFFF9800), size: 100),
            const SizedBox(height: 30),
            Text(
              isPoster
                  ? 'Welcome, Job Poster!'
                  : 'Welcome, Job Seeker!',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00897B),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              isPoster
                  ? 'Post and manage your local gigs below.'
                  : 'Browse available gigs in your area.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),

            if (!isPoster)
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JobListingsScreen()),
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text('Find Jobs'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),

            if (isPoster)
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PostJobScreen()),
                  );
                },
                icon: const Icon(Icons.post_add),
                label: const Text('Post a Job'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text('Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
