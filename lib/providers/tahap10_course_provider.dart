import 'package:flutter/material.dart';

import '../models/course.dart';
import '../repositories/course_repository.dart';

class Tahap10CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  Tahap10CourseProvider(this.repository);

  List<Course> courses = [];

  bool isLoading = false;
  bool isSaving = false;
  bool isDeleting = false;

  String? error;

  // GET: Mengambil daftar course
  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // CREATE: Menambahkan course
  Future<void> createCourse(Course course) async {
    if (isSaving) {
      throw Exception('Proses penyimpanan sedang berlangsung.');
    }

    isSaving = true;
    error = null;
    notifyListeners();

    try {
      await repository.createCourse(course);
      await loadCourses();
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // UPDATE: Memperbarui course
  Future<void> updateCourse(int id, Course course) async {
    if (isSaving) {
      throw Exception('Proses penyimpanan sedang berlangsung.');
    }

    isSaving = true;
    error = null;
    notifyListeners();

    try {
      await repository.updateCourse(id, course);
      await loadCourses();
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // DELETE: Menghapus course
  Future<void> deleteCourse(int id) async {
    if (isDeleting) {
      throw Exception('Proses penghapusan sedang berlangsung.');
    }

    isDeleting = true;
    error = null;
    notifyListeners();

    try {
      await repository.deleteCourse(id);
      await loadCourses();
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isDeleting = false;
      notifyListeners();
    }
  }
}
