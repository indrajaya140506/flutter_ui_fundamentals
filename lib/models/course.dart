class Course {
  final int? id;
  final String code;
  final String title;
  final int credits;
  final String status;
  final String category;

  const Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    this.status = 'planned',
    this.category = 'General',
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      code: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      credits: (json['credits'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'planned',
      category: json['category'] as String? ?? 'General',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'credits': credits,
      'status': status,
      'category': category,
    };
  }

  // Dipertahankan agar kode lama yang menggunakan toMap() tetap kompatibel.
  Map<String, dynamic> toMap() => toJson();
}
