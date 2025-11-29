// 📄 job.dart
// Represents a Job object (model)

class Job {
  final String title;
  final String pay;
  final String location;
  final String category;
  final String description;
  final DateTime datePosted;
  bool isCompleted;
  final String postedBy;
  final String contactInfo;

  Job({
    required this.title,
    required this.pay,
    required this.location,
    required this.category,
    required this.description,
    required this.datePosted,
    this.isCompleted = false,
    this.postedBy = 'Anonymous',
    this.contactInfo = 'No contact info',
  });
}