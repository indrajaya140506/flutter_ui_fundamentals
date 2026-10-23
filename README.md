# flutter_ui_fundamentals

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

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

# Tahap 1. Membaca REST Endpoint dan JSON

## 1. Endpoint yang Digunakan

- **URL Endpoint:** https://jsonplaceholder.typicode.com/posts/1
- **HTTP Method:** GET
- **Status Code:** 200 OK (apabila permintaan berhasil)
- **Resource:** posts
- **Response Format:** JSON

## 2. Response Body

```json
{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam"
}
```

## 3. Identifikasi Field JSON

| Field  | Tipe Data | Keterangan                           |
| ------ | --------- | ------------------------------------ |
| userId | Integer   | ID pengguna yang terkait dengan post |
| id     | Integer   | ID unik post                         |
| title  | String    | Judul post                           |
| body   | String    | Isi atau konten post                 |

## 4. Catatan/Temuan

Endpoint yang digunakan adalah `https://jsonplaceholder.typicode.com/posts/1` dengan metode HTTP GET untuk mengambil satu resource dari resource `posts`. Response body yang diterima berbentuk JSON dengan empat field utama, yaitu `userId`, `id`, `title`, dan `body`. Status HTTP 200 OK menunjukkan bahwa permintaan berhasil apabila status tersebut teramati saat pengujian.

JSONPlaceholder digunakan sebagai API latihan untuk memahami proses pengambilan data dari REST API. Operasi penulisan data pada layanan ini hanya disimulasikan sehingga perubahan tidak tersimpan secara permanen.
