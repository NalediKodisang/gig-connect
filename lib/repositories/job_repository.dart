// 📦 job_repository.dart
// Handles storing, fetching, deleting, and marking jobs completed (offline only)

import '../models/job.dart';

class JobRepository {
  // 🗂 Simulated local storage for all jobs
  static final List<Job> _jobs = [];

  // 🧩 Get all jobs
  static Future<List<Job>> getJobs() async {
    await Future.delayed(const Duration(milliseconds: 200)); // simulate delay
    return List<Job>.from(_jobs);
  }

  // ➕ Add a new job
  static Future<void> addJob(Job job) async {
    _jobs.add(job);
  }

  // ✅ Mark a job as completed
  static Future<void> markJobCompleted(Job job) async {
    final index = _jobs.indexWhere((j) => j.title == job.title);
    if (index != -1) {
      _jobs[index] = Job(
        title: job.title,
        pay: job.pay,
        location: job.location,
        category: job.category,
        description: job.description,
        datePosted: job.datePosted,
        isCompleted: true, // mark completed
      );
    }
  }

  // 🗑 Delete a job
  static Future<void> deleteJob(Job job) async {
    _jobs.removeWhere((j) => j.title == job.title);
  }

  // 🌱 Add sample jobs to make app look full
  static void seedSampleJobs() {
    if (_jobs.isEmpty) {
      _jobs.addAll([
        Job(
          title: 'Math Tutor Needed',
          pay: 'R150',
          location: 'Zakariyya Park',
          category: 'Tutoring',
          description: 'Help Grade 10 learner with algebra and geometry.',
          datePosted: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Job(
          title: 'Garden Clean-up',
          pay: 'R300',
          location: 'Lenasia South',
          category: 'Gardening',
          description: 'Small backyard cleanup for a family home.',
          datePosted: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Job(
          title: 'Deliver Groceries',
          pay: 'R100',
          location: 'Eldorado Park',
          category: 'Delivery',
          description: 'Quick delivery job, local area only.',
          datePosted: DateTime.now(),
        ),
      ]);
    }
  }
}
