# Train-Ticket-Reservation-Database-System

## Deskripsi Repository

Repository ini berisi proyek pembuatan database dalam pemesanan tiket kereta api. Proyek ini dikembangkan oleh kelompok 2 kelas Manajemen Basis Data F 2023 sebagai bagian dari final projek mata kuliah Manajemen Basis Data.

## Deskripsi Proyek

Proyek Sistem Database Reservasi Tiket Kereta Api adalah sebuah database yang dibuat untuk memudahkan proses pemesanan tiket kereta api. Database ini memiliki beberapa fitur penting, seperti penyimpanan informasi akun pengguna, kemampuan memesan makanan, pilihan tempat duduk, dan fungsi-fungsi umum dalam pemesanan tiket kereta api.

Dalam database ini, terdapat 8 entitas yang memiliki peran masing-masing:
1. Entitas "Pemesan" bertujuan untuk menyimpan informasi akun pengguna yang melakukan pemesanan.
2. Entitas "Kereta" digunakan untuk menyimpan data tentang kereta yang dapat dipesan, termasuk nama kereta, jam keberangkatan, dan stasiun awal.
3. Entitas "Menu_makanan" berfungsi untuk menyimpan daftar menu makanan beserta harga masing-masing menu pada setiap kereta.
4. Entitas "Transaksi_pemesanan" digunakan untuk mencatat semua transaksi pemesanan kereta yang dilakukan oleh pemesan.
5. Entitas "Feedback" digunakan untuk menyimpan feedback yang diberikan oleh setiap pemesan.
6. Entitas "TransaksiDetail_penumpang" bertujuan untuk menyimpan informasi lengkap mengenai setiap penumpang yang bukan pemesan.
7. Entitas "Tempat_duduk" digunakan untuk mengelola dan memantau ketersediaan tempat duduk pada setiap perjalanan kereta.
8. Entitas "Transaksi_makanan" berfungsi untuk mencatat semua informasi transaksi pemesanan makanan yang dilakukan oleh pemesan.

## Fitur

Proyek ini menggunakan SQL untuk mengelola dan memanipulasi basis data. Berikut adalah beberapa fitur utama yang diimplementasikan menggunakan SQL:

1. Sequence: Dalam struktur database ini, terdapat penggunaan penomoran otomatis (sequences) yang telah diatur. Hal ini memungkinkan penghasilan ID yang unik secara otomatis ketika terdapat penambahan atau perubahan data dalam database.
2. Fungsi "Tempat_Duduk_Func()": Fungsi ini dirancang untuk secara otomatis mengatur penomoran kursi yang tersedia pada setiap kereta. Dengan demikian, pengguna tidak perlu melakukan input manual terhadap penomoran tersebut.
3. Fungsi "Available_Func()": Fungsi ini digunakan untuk memberikan pesan jika kursi yang ingin dipesan telah tidak tersedia. Fungsi ini berperan penting dalam memberikan informasi yang akurat mengenai ketersediaan tempat duduk kepada pengguna.
4. Fungsi "update_available_tempat_duduk()": Fungsi ini bertujuan untuk mengubah status ketersediaan kursi pada entitas tempat_duduk setelah kursi tersebut berhasil dipesan. Hal ini memastikan bahwa informasi ketersediaan tempat duduk tetap terkini dalam database.
5. Trigger: Terdapat beberapa trigger yang telah diimplementasikan dalam database ini. Misalnya, trigger untuk menjalankan fungsi "tempat_duduk_func()" ketika terjadi perubahan pada entitas kereta, trigger untuk menjalankan fungsi "available_func()" saat terdapat perubahan pada entitas transaksipenumpang_detail, dan trigger untuk menjalankan fungsi "update_available_tempat_duduk()" ketika terdapat perubahan pada entitas transaksipenumpang_detail.
6. Pengindeksan (Indexing):
CREATE INDEX idx_nama ON kereta (nama_kereta);
CREATE INDEX idx_tanggal_berangkat ON kereta (tanggal_pemberangkatan);
Digunakan untuk mempercepat proses pencarian berdasarkan nama kereta dan tanggal pemberangkatan. Indeks ini membantu mengoptimalkan waktu yang diperlukan dalam proses pencarian data.
7. Tampilan (View): Dalam database ini, telah dibuat beberapa tampilan tabel (view) yang memungkinkan pengguna untuk mendapatkan informasi yang diinginkan tanpa mengubah entitas yang telah ada. Beberapa contoh tampilan tabel tersebut antara lain adalah omset setiap kereta, ketersediaan kursi, pemesanan makanan, dan daftar kereta yang paling diminati oleh pelanggan.

## Instalasi dan Penggunaan

Clone repository ini ke mesin lokal Anda.
   ```
   git clone https://github.com/njabdullah/Train-Ticket-Reservation-Database-System.git
   ```

Setelah Anda mengikuti langkah di atas, Anda dapat menjalankan proyek dan mulai menggunakan fitur-fitur SQL yang disediakan.
