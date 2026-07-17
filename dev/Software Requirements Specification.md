# **Software Requirements Specification (SRS) \- Dependency & Packages**

**Project Name:** OtoGrid (Hyperlocal On-Demand Mechanic)  
**Platform:** Flutter (Android & iOS)  
**Fase:** Zero-Cost MVP

## **1\. PENDAHULUAN**

Dokumen ini mendefinisikan seluruh *library* atau *package* pihak ketiga (pubspec.yaml) yang diizinkan dalam pengembangan OtoGrid. Penggunaan *package* di luar daftar ini harus dievaluasi secara ketat untuk mencegah *bloatware* (aplikasi menjadi berat) dan memastikan arsitektur tetap bersih (*Clean Architecture*).

## **2\. STATE MANAGEMENT & ARCHITECTURE**

*Package* ini beroperasi di lapisan **Presentation Layer** dan bertindak sebagai *Dependency Injector* untuk seluruh aplikasi.

* **flutter\_riverpod** (Versi 2.x+)  
  * *Fungsi:* State management utama aplikasi. Mengelola *state* reaktif (seperti *loading*, *error*, *success*) dan memisahkan logika UI dari kelas UI.  
* **riverpod\_annotation & build\_runner** (Dev Dependency)  
  * *Fungsi:* Menggunakan *code generation* agar penulisan *provider* Riverpod menjadi jauh lebih bersih, rapi, dan terhindar dari *boilerplate code*.  
* **fpdart** (Wajib untuk Clean Architecture)  
  * *Fungsi:* Memfasilitasi *Functional Programming* di Dart. Digunakan di **Domain Layer** untuk mengembalikan tipe data Either\<Failure, Success\>, sehingga aplikasi tidak akan pernah *crash* karena *Exception* yang tidak tertangani.  
* **equatable**  
  * *Fungsi:* Memudahkan perbandingan objek (*value equality*). Sangat krusial untuk *Entity* dan *Model* di Data Layer.

## **3\. CORE BACKEND & DATABASE (BaaS)**

Beroperasi di **Data Layer** untuk berkomunikasi dengan infrastruktur *Zero-Cost* (Supabase).

* **supabase\_flutter**  
  * *Fungsi:* *Package* resmi dari Supabase. Menangani 4 hal krusial sekaligus:  
    1. *Authentication* (Login Email).  
    2. *Database Queries* (Membaca/menulis data ke PostgreSQL).  
    3. *Realtime Subscriptions* (Mendengarkan *update* kordinat mekanik via WebSockets).  
    4. *Edge Functions Invocation* (Menembak fungsi AI Gemini yang di- *host* di Supabase).

## **4\. MAPS & GEOLOCATION (SPASIAL)**

Beroperasi di UI dan Data Layer untuk fitur hiperlokal.

* **flutter\_map**  
  * *Fungsi:* Mesin *rendering* peta *open-source*. Ini adalah pengganti Google Maps yang memungkinkan kita memuat *style* peta Mapbox secara gratis.  
* **latlong2**  
  * *Fungsi:* Dependensi wajib pendamping flutter\_map untuk kalkulasi matematika koordinat (Latitude & Longitude).  
* **geolocator**  
  * *Fungsi:* Mengakses GPS asli (*native*) dari HP Android/iOS pengguna untuk mendapatkan lokasi saat ini secara akurat.  
* **permission\_handler**  
  * *Fungsi:* Mengelola pop-up izin lokasi ("Izinkan aplikasi mengakses lokasi Anda?") dengan aman dan sesuai standar OS terbaru.

## **5\. ROUTING & NAVIGATION**

* **go\_router**  
  * *Fungsi:* Sistem navigasi deklaratif. Sangat penting untuk fitur **Role-Based Routing**. Jika pengguna masuk (*login*) sebagai mekanik, go\_router akan memblokir akses mereka ke halaman pelanggan menggunakan fitur *Redirect/Guards*.

## **6\. UI & DESIGN SYSTEM (Minimalist & Clean)**

Beroperasi murni di **Presentation Layer**.

* **google\_fonts**  
  * *Fungsi:* Mengimpor tipografi bersih secara otomatis (seperti *Inter* atau *Nunito*) tanpa harus menyimpan *file* font berat di dalam aset aplikasi.  
* **flutter\_svg**  
  * *Fungsi:* Me- *render* ikon vektor (.svg) agar ikon motor, bengkel, atau peringatan tetap tajam di semua ukuran layar dan ukuran *file* aplikasi tetap kecil.  
* **skeletonizer** (Opsional tapi Direkomendasikan)  
  * *Fungsi:* Membuat animasi *loading state* (kerangka abu-abu) secara otomatis saat aplikasi sedang mengambil data dari Supabase, memberikan kesan aplikasi sangat premium dan cepat.

## **7\. SECURITY & ENVIRONMENT**

* **flutter\_dotenv**  
  * *Fungsi:* Membaca file .env. Sangat krusial untuk menyembunyikan *Supabase URL*, *Supabase Anon Key*, dan *Mapbox Public Token* dari *source code* agar tidak bocor jika diunggah ke GitHub.

**Catatan Penting Arsitektur AI:**  
Perhatikan bahwa *package* google\_generative\_ai (Gemini SDK) **TIDAK DIMASUKKAN** ke dalam aplikasi Flutter ini. Sesuai PRD, demi keamanan *API Key*, eksekusi *prompt* ke Gemini akan dilakukan murni di sisi *server* menggunakan Supabase Edge Functions. Aplikasi Flutter hanya cukup memanggil Edge Function tersebut menggunakan supabase\_flutter.