// 📋 job_listings_screen.dart
import 'package:flutter/material.dart';
import '../models/job.dart';
import '../repositories/job_repository.dart';
import 'post_job_screen.dart';
import 'job_details_screen.dart'; //  Added so tapping a job shows its details

class JobListingsScreen extends StatefulWidget {
  const JobListingsScreen({super.key});

  @override
  State<JobListingsScreen> createState() => _JobListingsScreenState();
}

class _JobListingsScreenState extends State<JobListingsScreen> {
  List<Job> allJobs = [];
  List<Job> filteredJobs = [];
  String searchQuery = '';
  String selectedCategory = 'All';

  // 🏷 Categories list
  final List<String> categories = [
    'All',
    'Tutoring',
    'Delivery',
    'Cleaning',
    'Gardening',
    'Event Help',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    loadJobs();
  }

  // 🔄 Load jobs from repository
  Future<void> loadJobs() async {
    final jobs = await JobRepository.getJobs();
    setState(() {
      allJobs = jobs;
      filteredJobs = jobs;
    });
  }

  // Search & filter logic
  void filterJobs(String query, String category) {
    setState(() {
      searchQuery = query.toLowerCase();
      selectedCategory = category;

      filteredJobs = allJobs.where((job) {
        final matchesSearch = job.title.toLowerCase().contains(searchQuery);
        final matchesCategory = category == 'All' || job.category == category;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  //  Mark a job as completed
  void markJobAsDone(Job job) async {
    await JobRepository.markJobCompleted(job);
    setState(() {});
  }

  // 🗑 Delete a job
  void deleteJob(Job job) async {
    await JobRepository.deleteJob(job);
    loadJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Gigs'),
        backgroundColor: Colors.green,
      ),

      //  Floating Action Button to add a new job
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green, //  fixed typo
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostJobScreen()),
          );
          loadJobs(); // reload list
        },
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // 🔍 Search bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search jobs...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => filterJobs(value, selectedCategory),
            ),
            const SizedBox(height: 10),

            // Category filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  final isSelected = category == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      selectedColor: Colors.green,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          filterJobs(searchQuery, category);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),

            // 📋 Job list
            Expanded(
              child: filteredJobs.isEmpty
                  ? const Center(
                child: Text(
                  'No jobs found ',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: filteredJobs.length,
                itemBuilder: (context, index) {
                  final job = filteredJobs[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        job.title,
                        style:
                        const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${job.pay}'),
                          Text('${job.location}'),
                          Text(
                              '${job.datePosted.toLocal().toString().split(" ")[0]}'),
                          Text(' ${job.category}'),
                          if (job.isCompleted)
                            const Text(
                              '✅ Completed',
                              style: TextStyle(color: Colors.green),
                            ),
                        ],
                      ),

                      //  tapping opens job details page
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                JobDetailsScreen(job: job),
                          ),
                        );
                      },

                      // ⋮ Popup menu for actions
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'Done') markJobAsDone(job);
                          if (value == 'Delete') deleteJob(job);
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'Done',
                            child: Text('Mark as Done'),
                          ),
                          const PopupMenuItem(
                            value: 'Delete',
                            child: Text('Delete Job'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
