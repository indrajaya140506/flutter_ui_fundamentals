import 'package:flutter/foundation.dart';
import '../../models/course.dart';
import '../../repositories/course_repository.dart';

class Tahap10CourseProvider extends ChangeNotifier {
  final CourseRepository repository;

  Tahap10CourseProvider(this.repository);

  List<Course> _courses = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadCourses() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _courses = await repository.getCourses();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
