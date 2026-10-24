# Course Data Manager

Aplikasi Flutter untuk mengelola data course secara terstruktur dengan integrasi Supabase sebagai backend. Proyek ini dikembangkan dalam praktikum Flutter UI Fundamentals dengan penerapan widget, layout, state management, REST API, repository pattern, debugging, dan keamanan dasar.

## Identitas Mahasiswa

- **NIM:** 2455011001
- **Nama:** Komang Indrajaya Darmawiguna

## Fitur Utama

- Menampilkan daftar course.
- Menambahkan course baru.
- Mengedit informasi course.
- Menghapus course.
- Validasi input.
- Pengelolaan state menggunakan Provider.
- Penanganan error dan pemuatan ulang data.
- Integrasi database menggunakan Supabase.

## Teknologi

- Flutter
- Dart
- Provider
- Supabase
- REST API
- Git dan GitHub

## Arsitektur Project

Proyek menggunakan pemisahan tanggung jawab agar kode lebih terstruktur, mudah dipelihara, dan dikembangkan.

```text
lib/
├── config/
├── models/
├── providers/
├── repositories/
├── screens/
├── services/
├── widgets/
└── main.dart
```

**Alur dependency:**

```text
Screen → Provider → Repository → Service → Data Source
```

- **Config:** konfigurasi koneksi backend.
- **Models:** struktur data course.
- **Providers:** mengelola state aplikasi.
- **Repositories:** menjadi perantara antara provider dan sumber data.
- **Services:** menangani komunikasi dengan API atau Supabase.
- **Screens:** menampilkan halaman aplikasi.
- **Widgets:** komponen antarmuka yang dapat digunakan kembali.
- **Main:** titik masuk aplikasi dan konfigurasi sumber data aktif.

## Backend dan Database

Supabase digunakan sebagai backend untuk menyimpan dan mengelola data course. Kebijakan Row Level Security (RLS) menjadi salah satu lapisan pengamanan akses data.

JSONPlaceholder juga digunakan pada tahap praktikum REST API untuk mempelajari request HTTP, respons JSON, dan pemetaan data. Operasi penulisan pada JSONPlaceholder bersifat simulasi dan tidak menyimpan perubahan secara permanen.

## Persyaratan

- Flutter SDK dan Dart SDK.
- Editor kode, seperti Visual Studio Code.
- Emulator Android atau perangkat yang mendukung Flutter.
- Proyek Supabase yang telah dikonfigurasi.

## Cara Menjalankan

1. Clone repository:

   ```bash
   git clone https://github.com/indrajaya140506/flutter_ui_fundamentals.git
   ```

2. Masuk ke folder proyek:

   ```bash
   cd flutter_ui_fundamentals
   ```

3. Unduh dependensi:

   ```bash
   flutter pub get
   ```

4. Pastikan konfigurasi Supabase tersedia pada:

   ```text
   lib/config/supabase_config.dart
   ```

   Gunakan URL proyek dan publishable/anon key yang sesuai. Jangan menggunakan `service_role` key di aplikasi Flutter.

5. Jalankan aplikasi:

   ```bash
   flutter run
   ```

## Pemeriksaan Kode

Format kode Dart:

```bash
dart format lib
```

Analisis statis:

```bash
flutter analyze
```

## Keamanan

- Jangan memasukkan password, token pribadi, atau `service_role` key ke repository.
- Jangan commit file `.env` yang berisi secret.
- Terapkan RLS dan authorization pada backend sesuai kebutuhan akses.
- Jangan mengandalkan validasi UI sebagai pengganti validasi backend.
- Hindari menampilkan informasi sensitif dalam screenshot dan log.

## Repository

GitHub: https://github.com/indrajaya140506/flutter_ui_fundamentals
