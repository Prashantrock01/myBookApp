class Book {
  final String title;
  final String authorName;
  final int? coverId;
  final String key;
  final String? description;
  final int? firstPublishYear;
  final List<String>? subjects;

  Book({
    required this.title,
    required this.authorName,
    required this.coverId,
    required this.key,
    this.description,
    this.firstPublishYear,
    this.subjects,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'No Title',
      authorName: (json['authors'] != null && json['authors'].isNotEmpty)
          ? json['authors'][0]['name'] ?? 'Unknown'
          : 'Unknown',
      coverId: json['cover_id'],
      key: json['key'] ?? '',
      description: json['description'] is Map
          ? json['description']['value'] // sometimes it's an object
          : json['description'] ?? 'No description',
      firstPublishYear: json['first_publish_year'],
      subjects: (json['subject'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  String get coverUrl {
    if (coverId != null) {
      return 'https://covers.openlibrary.org/b/id/$coverId-L.jpg';
    } else {
      return 'https://via.placeholder.com/100x150.png?text=No+Cover';
    }
  }

  String get bookId => key.isNotEmpty ? key : 'unknown';
}
