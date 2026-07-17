# **OtoGrid — Hyperlocal On-Demand Mechanic & AI Triage**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-teal.svg?logo=dart)](https://dart.dev)
[![Supabase](https://img.shields.io/badge/Backend-Supabase-green.svg?logo=supabase)](https://supabase.com)
[![Gemini](https://img.shields.io/badge/AI_Engine-Gemini_Flash-purple.svg?logo=google-gemini)](https://ai.google.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean_Architecture-lightgrey.svg)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

**OtoGrid** adalah platform *Micro-SaaS* hiperlokal yang dirancang khusus untuk menghubungkan pengendara sepeda motor yang mengalami kendala darurat di jalan (seperti ban bocor atau mogok) dengan bengkel UMKM dan mekanik independen terdekat secara *real-time*. 

Aplikasi ini menggunakan satu *codebase* terpadu (*Unified App*) dengan *Role-Based Routing* dan mengadopsi strategi **Zero-Cost Architecture** menggunakan kombinasi *free-tier* dari berbagai penyedia layanan *cloud*.

---

## **1. Masalah & Solusi**

### **Masalah (Pain Points)**
* **Konsumen:** Mengalami kepanikan saat motor mogok di jalan raya, harus mendorong motor tanpa arah yang jelas, serta rentan terhadap manipulasi tarif perbaikan oleh mekanik nakal.
* **Mitra (Mekanik UMKM):** Kesulitan menjangkau pelanggan baru secara digital karena keterbatasan lokasi bengkel (misalnya masuk gang) dan tidak memiliki sistem penemuan pesanan darurat.

### **Solusi (OtoGrid)**
* **AI Triage (Diagnosis Cerdas):** Pelanggan dapat mengeluhkan kendala motor dengan bahasa sehari-hari. AI (Google Gemini) akan mendiagnosis kerusakan secara otomatis dan memformatnya menjadi daftar perbaikan teknis terstruktur bagi mekanik.
* **Geospatial Matching:** Sistem *routing* spasial menggunakan database PostGIS untuk mencocokkan pengendara dengan mekanik terdekat dalam radius maksimal 5 KM.
* **Real-time Tracking:** Pelacakan koordinat GPS mekanik secara langsung (*live*) di peta pelanggan menggunakan koneksi WebSockets melalui Supabase Realtime.
* **Mikro-Ekonomi Pay-Per-Lead:** Mekanik membeli koin digital murah untuk mengambil pekerjaan darurat tanpa komisi tambahan dari hasil servis.

---

## **2. Design System & Filosofi Visual**

Berdasarkan *Style Requirements Specification*, OtoGrid mengusung gaya **Minimalism & Bento Grid** untuk meminimalisasi beban kognitif pengendara saat panik:
* **Primary Color (Action):** `#2A9D8F` (Persian Green) — Melambangkan keamanan dan ketenangan.
* **Secondary Color (Alert/Danger):** `#E76F51` (Burnt Orange) — Digunakan untuk status darurat, pembatalan, dan peringatan.
* **Neutral Background:** `#FFFFFF` (Pure White) & `#F8F9FA` (Soft Gray).
* **Text / Typography:** `#264653` (Charcoal) — Menghindari kontras hitam pekat demi kenyamanan mata.
* **Typography Family:** Inter (via Google Fonts).
* **Corner Radius:** `16dp` pada seluruh elemen *cards* dan tombol.
* **Button Sizing:** Tinggi tombol utama minimal `56dp` agar mudah ditekan dalam kondisi tangan berkeringat/gemetar.

---

## **3. Tech Stack & Strategi Zero-Cost**

Aplikasi ini dibangun menggunakan arsitektur *cost-efficient* tanpa biaya server bulanan untuk skala MVP:
* **Frontend:** Flutter & State Management **Riverpod**.
* **Database & BaaS:** **Supabase** (PostgreSQL + PostGIS, Auth, Database Queries).
* **Maps & Geo-routing:** **flutter_map** dengan **Mapbox SDK** (*Free Tier* 50.000 *map loads*/bulan).
* **AI Engine:** **Google Gemini API** (diakses secara aman via Supabase Edge Functions).
* **Real-time Engine:** Supabase Realtime Subscriptions (koneksi WebSocket gratis).

---

## **4. Struktur Folder (Clean Architecture)**

Proyek ini dipisahkan secara ketat menjadi tiga lapisan utama (*Layer*):
```
lib/
├── core/
│   ├── constants/    # Konfigurasi global (warna, dimensi, dll.)
│   ├── router/       # Logika GoRouter & Role-Based Guarding
│   ├── theme/        # Tema aplikasi (AppTheme)
│   ├── utils/        # Utility helpers
│   └── widgets/      # Shared/Global Widgets
└── features/
    ├── auth/         # Autentikasi User & Pendaftaran
    ├── map/          # Peta Pelanggan, Live Tracking & Permintaan Darurat
    ├── triage/       # Diagnosis AI & Dashboard Mekanik (Job Feed)
    └── wallet/       # Pembelian & Transaksi Koin Mekanik
        ├── data/         # Repositori & Data Sources
        ├── domain/       # Use Cases & Entities (Logic Utama)
        └── presentation/ # Widgets & Riverpod Controllers (UI)
```

---

## **5. Cara Memulai & Setup Lokal**

### **Prasyarat (Prerequisites)**
* [Flutter SDK](https://docs.flutter.dev/get-started/install) versi 3.22.x atau yang lebih baru.
* Akun [Supabase](https://supabase.com) (untuk database dan autentikasi).
* Akun [Mapbox](https://mapbox.com) (untuk peta dasar).

### **Langkah Inisialisasi**

1. **Clone repositori ini:**
   ```bash
   git clone https://github.com/username/oto_grid.git
   cd oto_grid
   ```

2. **Setup file Environment (.env):**
   Salin berkas `.env.example` menjadi `.env` di direktori akar proyek:
   ```bash
   cp .env.example .env
   ```
   Isi variabel berikut dengan kunci API Anda sendiri:
   ```env
   SUPABASE_URL=https://your-project-id.supabase.co
   SUPABASE_ANON_KEY=your-supabase-anon-key
   MAPBOX_ACCESS_TOKEN=your-mapbox-access-token
   ```

3. **Unduh Package Dependencies:**
   ```bash
   flutter pub get
   ```

4. **Jalankan Static Analysis & Verifikasi:**
   Jalankan penganalisis kode statis untuk memastikan tidak ada kesalahan sintaksis:
   ```bash
   dart analyze
   ```

5. **Jalankan Unit/Widget Test:**
   Jalankan rangkaian pengujian otomatis untuk memverifikasi fungsionalitas:
   ```bash
   flutter test
   ```

6. **Jalankan Aplikasi:**
   ```bash
   flutter run
   ```

---

## **6. Keamanan & Kebijakan Git**

* **Keamanan API Key:** Berkas `.env` telah didaftarkan ke `.gitignore`. **Jangan pernah** melakukan kompilasi kunci API secara *hardcoded* di dalam kode Flutter. Semua panggilan eksternal berbayar (seperti Gemini API) harus dilewatkan melalui *Edge Function* Supabase.
* **Kebijakan Commit:** Selalu pastikan `dart analyze` bersih dari warning dan error sebelum membuat pull request baru.
