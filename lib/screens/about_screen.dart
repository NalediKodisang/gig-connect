import 'package:flutter/material.dart';

// 🪧 About / Help Screen
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🟢 AppBar at the top
      appBar: AppBar(
        title: const Text('About / Help'),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 3,
      ),

      // 📖 Body content
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🧩 Section 1: App info
            const Text(
              'About Gig Connect',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,

                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Gig Connect is a community-based mobile app designed to help '
                  'youth in Zakariyya Park find and offer short-term gig work — '
                  'like tutoring, deliveries, gardening, or event help.\n\n'
                  'It connects local talent with local opportunities, promoting '
                  'employment and entrepreneurship in the community.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 25),

            // 🧩 Section 2: How to use the app
            const Text(
              'How It Works',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '1️⃣ Browse jobs under the “Find Jobs” section.\n'
                  '2️⃣ Post new gigs under the “Post a Job” section.\n'
                  '3️⃣ Use filters or search to find specific types of work.\n'
                  '4️⃣ Contact the poster directly through phone or WhatsApp.\n'
                  '5️⃣ Rate or review jobs (coming soon!).',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 25),

            // 🧩 Section 3: Tips
            const Text(
              'Tips for Staying Safe',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '✔️ Meet in public places when possible.\n'
                  '✔️ Avoid sharing personal financial information.\n'
                  '✔️ Verify job posters before accepting work.\n'
                  '✔️ Use the app’s rating system to build trust in the community.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 25),

            // 🧩 Section 4: Contact / Support
            const Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you experience issues or have suggestions, please contact us:',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 8),

            Row(
              children: const [
                Icon(Icons.email, color: Colors.green),
                SizedBox(width: 8),
                Text('support@gigconnect.co.za'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: const [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 8),
                Text('+27 81 517 9149'),
              ],
            ),

            const SizedBox(height: 30),
            const Divider(thickness: 1),
            const Center(
              child: Text(
                '© 2025 Gig Connect - All Rights Reserved',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
