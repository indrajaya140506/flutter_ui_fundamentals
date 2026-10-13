class Course {
  final String code;
  final String title;
  final int credits;
  final String status;
  final String category;

  const Course({
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
    required this.category,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      code: json['code'].toString(),
      title: json['title'].toString(),
      credits: (json['credits'] as num).toInt(),
      status: json['status'].toString(),
      category: json['category']?.toString() ?? 'General',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'title': title,
      'credits': credits,
      'status': status,
      'category': category,
    };
  }
}
