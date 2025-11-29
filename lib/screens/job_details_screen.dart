import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/job.dart';
import '../repositories/user_repository.dart';

class JobDetailsScreen extends StatelessWidget {
  final Job job;
  const JobDetailsScreen({super.key, required this.job});

  //  Try open WhatsApp / phone dialer
  Future<void> _contactPoster(BuildContext context) async {
    final contact = job.contactInfo.trim();

    // 🟢 WhatsApp link if contact has digits
    final whatsappUrl = Uri.parse("https://wa.me/$contact");
    final phoneUrl = Uri.parse("tel:$contact");

    if (RegExp(r'^\d+$').hasMatch(contact)) {
      // Try WhatsApp first
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl);
      } else if (await canLaunchUrl(phoneUrl)) {
        await launchUrl(phoneUrl);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open contact for $contact')),
        );
      }
    } else {
      // If not a number, just show a message popup
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contact: $contact')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRole = UserRepository.getCurrentUserRole();

    return Scaffold(
      appBar: AppBar(title: Text(job.title), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Pay: ${job.pay}'),
                Text('Location: ${job.location}'),
                Text('Category: ${job.category}'),
                const Divider(height: 20),
                const Text('Description:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(job.description),
                const SizedBox(height: 20),
                Text('Posted by: ${job.postedBy}'),
                Text('Contact: ${job.contactInfo}'),
                const SizedBox(height: 30),

                // 👇 Only Job Seekers can contact the poster
                if (currentRole == 'Job Seeker')
                  ElevatedButton(
                    onPressed: () => _contactPoster(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Contact Poster'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
