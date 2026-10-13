import 'package:flutter/foundation.dart';

class CourseState extends ChangeNotifier {
  final Set<String> favorites = {};

  // Mengecek apakah course sudah menjadi favorite.
  bool isFavorite(String code) {
    return favorites.contains(code);
  }

  // Menambah atau menghapus favorite.
  void toggleFavorite(String code) {
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }

    // Memberi tahu semua screen bahwa state berubah.
    notifyListeners();
  }

  // Mengambil jumlah course favorite.
  int get favoriteCount => favorites.length;
}
