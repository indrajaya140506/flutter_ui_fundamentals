class Course {
  final int? id;
  final String code;
  final String title;
  final int credits;
  final String status;
  final DateTime? createdAt;

  // Kompatibilitas dengan halaman UI yang sudah ada.
  final String category;

  const Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
    this.createdAt,
    this.category = 'General',
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] == null ? null : (json['id'] as num).toInt(),
      code: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      credits: (json['credits'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'planned',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'].toString()),
      category: json['category'] as String? ?? 'General',
    );
  }

  // Khusus payload tabel Supabase courses.
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'code': code,
      'title': title,
      'credits': credits,
      'status': status,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  // Mempertahankan kompatibilitas kode lama.
  Map<String, dynamic> toMap() => toJson();
}
