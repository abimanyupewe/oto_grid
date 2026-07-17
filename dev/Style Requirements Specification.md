# **Style Requirements Specification (SRS) \- Visual & Design System**

**Project Name:** OtoGrid  
**Design Philosophy:** Minimalist, Functional, Trustworthy.

## **1\. DESIGN PHILOSOPHY**

Aplikasi harus terasa seperti "alat bantu darurat". Fokus utama adalah:

* **Minimalism:** Ruang kosong (*whitespace*) yang luas untuk mengurangi beban kognitif pengguna saat panik.  
* **Predictability:** Penempatan tombol aksi (CTA) yang konsisten di setiap layar.  
* **Accessibility:** Kontras tinggi agar mudah dibaca di bawah terik matahari siang hari.

## **2\. COLOR PALETTE**

Kita menggunakan sistem warna yang memberikan rasa "aman" dan "cepat" tanpa terlihat berlebihan.

* **Primary (Action):** \#2A9D8F (Persian Green). Warna ini melambangkan keamanan dan ketenangan. Digunakan untuk tombol utama "Minta Bantuan", "Pesan Mekanik", dan "Konfirmasi".  
* **Secondary (Alert/Danger):** \#E76F51 (Burnt Orange). Warna ini digunakan untuk status "Mogok", "Peringatan", atau "Batal". Memberikan urgensi namun tidak mencolok mata seperti merah murni.  
* **Neutral (Background):** \#FFFFFF (Pure White) & \#F8F9FA (Soft Gray). Gunakan White untuk *card* konten dan Soft Gray untuk *background* layar.  
* **Typography/Text:** \#264653 (Charcoal). Menggunakan warna ini untuk teks utama daripada hitam murni untuk mengurangi kelelahan mata (*eye strain*).

## **3\. TYPOGRAPHY (Google Fonts)**

Gunakan font yang memiliki keterbacaan tinggi di berbagai ukuran layar.

* **Font Family:** Inter (Sans-serif modern, sangat bersih).  
* **Hierarchy:**  
  * *Headline:* 24sp, Semi-bold.  
  * *Sub-headline:* 18sp, Medium.  
  * *Body Text:* 14sp, Regular.  
  * *Buttons:* 16sp, Bold, All Caps (opsional).

## **4\. UI COMPONENTS SPECIFICATION**

* **Corner Radius (Rounded Corners):** Gunakan 16dp untuk semua kartu (*cards*) dan tombol (*buttons*). Ini memberikan kesan modern namun ramah.  
* **Elevation (Shadows):** Gunakan *soft shadow* untuk kartu konten guna memberikan efek kedalaman (*depth*).  
  * x: 0, y: 4, blur: 20, color: \#0000001A.  
* **Button Sizing:** Tinggi tombol utama minimal 56dp agar mudah ditekan meskipun tangan pengguna sedang gemetar atau berkeringat saat mogok.

## **5\. UI/UX GUIDELINES FOR HYPERLOCAL MAP**

* **Map Style:** Gunakan *style* peta "Light/Minimal". Matikan *Point of Interest* (POI) yang tidak perlu (seperti nama toko kecil atau nama gedung yang tidak relevan) agar peta bersih, hanya menampilkan jalan dan ikon mekanik.  
* **Marker Consistency:**  
  * Ikon Mekanik: Gunakan flutter\_svg untuk ikon mekanik yang *scalable*. Gunakan warna Primary (\#2A9D8F) agar menonjol di atas peta.  
  * Ikon Pengguna: Gunakan pin berwarna biru (\#457B9D).

## **6\. CONSISTENCY RULE**

* **No Multi-Color Hell:** Jangan gunakan lebih dari 3 warna utama di satu layar.  
* **Iconography:** Gunakan *set* ikon dari Heroicons atau Lucide Icons untuk tampilan yang tipis, bersih, dan modern.