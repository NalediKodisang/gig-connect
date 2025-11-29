import 'package:flutter/material.dart';
import '../models/job.dart';
import '../repositories/job_repository.dart';
import '../repositories/user_repository.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController payController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String selectedCategory = 'Other';

  final List<String> categories = [
    'Tutoring',
    'Delivery',
    'Cleaning',
    'Gardening',
    'Event Help',
    'Other',
  ];

  Future<void> postJob() async {
    if (titleController.text.isEmpty ||
        payController.text.isEmpty ||
        locationController.text.isEmpty ||
        contactController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(' Please fill in all required fields')),
      );
      return;
    }

    final job = Job(
      title: titleController.text.trim(),
      pay: payController.text.startsWith('R')
          ? payController.text
          : 'R${payController.text}',
      location: locationController.text.trim(),
      category: selectedCategory,
      description: descriptionController.text.trim(),
      contactInfo: contactController.text.trim(),
      postedBy: UserRepository.getCurrentUserEmail() ?? 'Unknown User',
      datePosted: DateTime.now(),
    );

    await JobRepository.addJob(job);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Job Posted Successfully!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Job'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Job Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: payController,
              decoration: const InputDecoration(labelText: 'Pay (e.g. 150)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactController,
              decoration: const InputDecoration(
                labelText: 'Contact Info (email / phone)',
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => selectedCategory = value!),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: postJob,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Submit Job'),
            ),
          ],
        ),
      ),
    );
  }
}
