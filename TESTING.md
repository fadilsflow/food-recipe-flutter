# Testing Guide - Auth Feature

Dokumentasi ini menjelaskan cara menjalankan testing untuk fitur autentikasi di aplikasi Flutter Storage.

## 📋 Daftar Test

### 1. Unit Testing

**File**: `test/unit/auth_service_test.dart`

**Tujuan**: Menguji logika bisnis `AuthService` secara terisolasi menggunakan mock dependencies.

**Test Cases**:

- ✅ Login berhasil dengan kredensial yang valid (status 200)
- ✅ Login gagal dengan kredensial yang invalid (throw exception)

**Cara Menjalankan**:

```bash
flutter test test/unit/auth_service_test.dart
```

### 2. Widget Testing

**File**: `test/widget/login_page_test.dart`

**Tujuan**: Menguji UI dan interaksi widget `LoginPage`.

**Test Cases**:

- ✅ Semua elemen UI ditampilkan dengan benar (Welcome Back, Login button, Email field, Password field, Register link)
- ✅ User dapat memasukkan text ke dalam field email dan password

**Cara Menjalankan**:

```bash
flutter test test/widget/login_page_test.dart
```

### 3. Integration Testing

**File**: `integration_test/auth_integration_test.dart`

**Tujuan**: Menguji alur lengkap autentikasi dari UI hingga API secara end-to-end.

**Test Cases**:

- ✅ Alur login lengkap: input kredensial dan navigasi ke home page
- ✅ Validasi form: login dengan field kosong menampilkan error
- ✅ Navigasi: berpindah ke halaman register dan kembali

**Cara Menjalankan**:

```bash
# Untuk Android
flutter test integration_test/auth_integration_test.dart

# Atau dengan device/emulator yang sedang berjalan
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/auth_integration_test.dart
```

## 🚀 Menjalankan Semua Test

### Menjalankan Semua Unit & Widget Test

```bash
flutter test
```

### Menjalankan Test dengan Coverage

```bash
flutter test --coverage
```

Untuk melihat coverage report:

```bash
# Install lcov terlebih dahulu (Mac)
brew install lcov

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Buka di browser
open coverage/html/index.html
```

## 🛠️ Setup Dependencies

Pastikan dependencies berikut sudah ada di `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.8
```

Install dependencies:

```bash
flutter pub get
```

Generate mock files (untuk unit testing):

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📝 Struktur Test

```
flutter_storage/
├── test/
│   ├── unit/
│   │   └── auth_service_test.dart          # Unit test untuk AuthService
│   └── widget/
│       └── login_page_test.dart            # Widget test untuk LoginPage
├── integration_test/
│   └── auth_integration_test.dart          # Integration test untuk auth flow
└── test_driver/
    └── integration_test.dart               # Driver untuk integration test
```

## 🧪 Best Practices

1. **Unit Testing**:

   - Gunakan mock untuk dependencies eksternal (Dio, Storage, dll)
   - Test satu fungsi/method per test case
   - Fokus pada logika bisnis, bukan implementasi detail

2. **Widget Testing**:

   - Test UI rendering dan interaksi user
   - Gunakan `pumpAndSettle()` untuk menunggu animasi selesai
   - Verifikasi state changes setelah interaksi

3. **Integration Testing**:
   - Test alur lengkap dari perspektif user
   - Gunakan kredensial test yang valid
   - Test di device/emulator yang sebenarnya

## 🔍 Troubleshooting

### Error: "No tests found"

Pastikan file test memiliki suffix `_test.dart` dan berada di folder `test/` atau `integration_test/`.

### Error: "Missing mock files"

Jalankan build_runner untuk generate mock:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Integration test gagal

- Pastikan emulator/device sudah berjalan
- Pastikan API backend sudah running (untuk test yang membutuhkan koneksi real)
- Gunakan kredensial test yang valid

## 📊 Coverage Target

Target minimum code coverage:

- **Unit Tests**: 80%
- **Widget Tests**: 70%
- **Integration Tests**: Critical user flows

## 🔗 Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Integration Testing Guide](https://docs.flutter.dev/testing/integration-tests)
