# **Product Requirements Document (PRD)**

**Project Name:** OtoGrid (Hyperlocal On-Demand Mechanic)  
**Platform:** Mobile App (Unified App untuk Android & iOS)  
**Versi Dokumen:** 1.1 (Revisi: Zero-Cost MVP Architecture)  
**Fase MVP:** Skala Kota (Malang: Area Kampus / Suhat / Dinoyo)

## **1\. EXECUTIVE SUMMARY**

**OtoGrid** adalah platform SaaS mikro (*Micro-SaaS*) hiperlokal yang menghubungkan pengendara sepeda motor yang mengalami kendala di jalan (mogok, ban bocor) dengan bengkel UMKM atau mekanik independen terdekat secara *real-time*. Platform ini menggunakan kecerdasan buatan (LLM) untuk mendiagnosis masalah secara otomatis dan menggunakan kalkulasi spasial untuk menemukan bantuan tercepat. MVP ini dirancang dengan arsitektur *Zero-Cost* (bebas biaya server bulanan) menggunakan kombinasi *Free Tier* dari berbagai penyedia layanan *cloud*.

## **2\. PROBLEM & SOLUTION**

### **2.1 Masalah (Pain Points)**

* **Konsumen:** Mengalami kepanikan saat motor mogok, harus mendorong motor tanpa arah, dan rentan terhadap pemerasan harga oleh mekanik yang tidak transparan.  
* **Mitra (Mekanik UMKM):** Kehilangan potensi pendapatan karena lokasi bengkel kurang strategis (di dalam gang) dan tidak memiliki sistem penemuan pelanggan darurat.

### **2.2 Solusi (OtoGrid)**

* **Penemuan Spasial:** *Routing* otomatis dalam radius maksimal 5 KM menggunakan database PostGIS.  
* **Diagnosis Cerdas:** Pengguna mengetik masalah dengan bahasa awam, AI menerjemahkannya menjadi daftar kemungkinan kerusakan teknis untuk mekanik.  
* **Transparansi Harga:** Katalog estimasi biaya perbaikan standar sebelum pemesanan dikonfirmasi.

## **3\. USER PERSONA & SCOPE (Batas MVP)**

### **3.1 Target Pengguna**

* **Pelanggan:** Mahasiswa atau pekerja muda di Malang yang memiliki mobilitas tinggi dengan roda dua namun minim pengetahuan mesin.  
* **Mitra:** Pemilik bengkel kecil atau mekanik independen (terverifikasi) yang mencari tambahan pesanan masuk.

### **3.2 Batasan Scope (Out of Scope untuk MVP)**

* TIDAK melayani mobil atau kendaraan roda empat.  
* TIDAK ada integrasi Payment Gateway/Dompet Digital internal (pembayaran murni tunai/QRIS langsung ke mekanik).  
* TIDAK menggunakan otentikasi OTP SMS/WhatsApp berbayar (murni Email).

## **4\. ARCHITECTURE & TECH STACK (ZERO-COST STRATEGY)**

Proyek ini DIWAJIBKAN mengadopsi **Clean Architecture** (pemisahan *Domain*, *Data*, dan *Presentation Layer*) dan *Clean Code* (SOLID Principles).

### **4.1 Tech Stack Inti & Pengelolaan Biaya**

* **Frontend (Aplikasi):** Flutter (Satu *codebase* dengan *Role-Based Routing*).  
* **State Management:** Riverpod.  
* **Maps & Routing:** flutter\_map dengan **Mapbox SDK** (*Free Tier: 50.000 map loads/bulan*, lebih hemat dari Google Maps).  
* **Backend & Database:** **Supabase Free Tier** (Mencakup PostgreSQL \+ PostGIS, 500 MB *Storage*, 50.000 MAU).  
* **Real-time Engine:** Supabase Realtime Subscriptions (WebSocket bawaan, gratis dalam batas *Free Tier*).  
* **AI Engine:** **Google Gemini API** (Memanfaatkan kuota gratis / akses via akun Google Pro). Model yang digunakan difokuskan pada gemini-1.5-flash (atau varian tercepat) untuk efisiensi pemrosesan teks.

### **4.2 Sistem Satu Aplikasi Terpadu (Unified App)**

* Menggunakan satu aplikasi untuk kedua belah pihak.  
* Otentikasi menggunakan **Email murni** via Supabase Auth (Biaya Rp 0).  
* Setelah otentikasi, sistem membaca role dari database:  
  * role \== 'customer': Masuk ke antarmuka Peta Darurat.  
  * role \== 'mechanic': Masuk ke antarmuka *Dashboard* Penerimaan Pesanan.

### **4.3 Keamanan API (Edge Function)**

* Panggilan ke Gemini API **TIDAK BOLEH** dilakukan langsung dari aplikasi Flutter untuk mencegah pencurian *API Key*. Panggilan harus di- *routing* melalui Supabase *Edge Functions* yang bertindak sebagai jembatan perantara yang aman.

## **5\. FITUR UTAMA (CORE FEATURES)**

### **5.1 Modul 1: Auth & Keamanan**

* Pendaftaran via Email.  
* **Customer:** Langsung aktif dan bisa memesan.  
* **Mechanic:** Akun berstatus *Pending* hingga diverifikasi (KYC) secara manual oleh Admin.  
* Sistem pemblokiran senyap (*shadowban*) untuk *Device ID* dan email yang dilaporkan melakukan pesanan fiktif (*prank*).

### **5.2 Modul 2: AI Triage (Diagnosis Awal)**

* Pelanggan mengetik keluhan (Misal: "Ban belakang goyang").  
* Edge Function mengirimkan *prompt* rahasia beserta teks pelanggan ke Gemini API untuk menghasilkan format terstruktur JSON: {"label": "Kerusakan Ban/Velg", "tingkat\_urgensi": "Sedang", "alat\_wajib": "Kunci Pas, Pompa"}.

### **5.3 Modul 3: Geospatial Matching & Live Tracking**

* Sistem memancarkan sinyal darurat hanya kepada mekanik dengan status *Online* dalam radius 5 KM (menggunakan ekstensi PostGIS: ST\_DWithin).  
* Saat mekanik menyetujui, titik GPS mekanik dikirim setiap 5 detik ke Supabase, dan bergeser secara *real-time* di layar pelanggan melalui fitur WebSocket (*Subscription*).

### **5.4 Modul 4: Ekonomi Mikro (Sistem Koin Pay-Per-Lead)**

* **Model Bisnis MVP:** Bebas komisi servis.  
* Mekanik harus memiliki saldo Koin Digital (misal deposit manual ke Admin).  
* Setiap kali mekanik mengambil pesanan darurat, saldo Koin dipotong dengan nilai nominal kecil (Misal: 2 Koin \= Rp 2.000).

## **6\. DEVELOPMENT PHASES (ROADMAP)**

### **Fase 1: Fondasi Arsitektur & Database (Minggu 1\)**

* Setup *Clean Architecture* *folder structure* di Flutter.  
* Setup proyek Supabase gratis, tabel database (users, mechanic\_locations, requests), dan konfigurasi RLS (Row Level Security).  
* Konfigurasi Mapbox token.

### **Fase 2: Autentikasi & Routing (Minggu 2\)**

* Implementasi Supabase Auth (Email) dan Riverpod *State Management*.  
* Membangun logika *Role-Based Routing* (Customer vs Mechanic screen).

### **Fase 3: Peta, Triage AI, & WebSocket (Minggu 3-4)**

* Implementasi antarmuka flutter\_map.  
* *Deploy* Supabase Edge Function untuk memanggil Gemini API dengan lancar.  
* Membangun logika langganan data (*stream*) untuk *Live Tracking* koordinat mekanik.

### **Fase 4: Pengujian Lapangan di Malang (Minggu 5\)**

* *Debugging* logika sistem potong koin dan notifikasi *prank*.  
* Uji coba aplikasi nyata di area Suhat/Dinoyo dengan 2 perangkat (satu pelanggan, satu mekanik di motor berjalan).