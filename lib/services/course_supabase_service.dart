import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';
import 'course_data_source.dart';

class CourseSupabaseService implements CourseDataSource {
  CourseSupabaseService({SupabaseClient? client})
    : _supabase = client ?? Supabase.instance.client;

  final SupabaseClient _supabase;

  @override
  Future<List<Course>> getCourses() async {
    final data = await _supabase.from('courses').select().order('id');

    return (data as List)
        .map((e) => Course.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  // Akan diimplementasikan pada tahap berikutnya.
  @override
  Future<Course> createCourse(Course course) async {
    final row = await _supabase
        .from('courses')
        .insert(course.toJson())
        .select()
        .single();

    return Course.fromJson(Map<String, dynamic>.from(row));
  }

  @override
  Future<void> updateCourse(int id, Course course) async {
    await _supabase.from('courses').update(course.toJson()).eq('id', id);
  }

  @override
  Future<void> deleteCourse(int id) async {
    await _supabase.from('courses').delete().eq('id', id);
  }
}
