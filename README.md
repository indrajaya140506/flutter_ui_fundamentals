# flutter\_ui\_fundamentals

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

* [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
* [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
* [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Flutter UI Fundamentals

NIM: 2455011001  
Nama: Komang Indrajaya Darmawiguna

Project ini merupakan hasil praktikum Flutter UI Fundamentals yang mencakup widget dasar, layout, state, collection, JSON, FutureBuilder, Learning Dashboard, dan debugging.

## Arsitektur Project



\- `models/`: Menyimpan struktur data course.

\- `services/`: Memuat data JSON menggunakan rootBundle dan jsonDecode.

\- `repositories/`: Menjadi perantara antara Provider dan Service.

\- `providers/`: Mengelola state dan menyediakan data untuk UI.

\- `screens/`: Menampilkan halaman dan antarmuka aplikasi.

\- `main.dart`: Titik masuk aplikasi Flutter.



Arah dependency:

Screen → Provider → Repository → Service/Data Source.



Pemisahan tanggung jawab membuat kode lebih terstruktur dan mudah dipelihara.

