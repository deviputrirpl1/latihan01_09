import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// =====================================================
// FORMAT RUPIAH
// =====================================================

final rupiah = NumberFormat('#,###', 'id_ID');

class Pembeli {
  String nama;
  bool anggota;

  Pembeli({
    required this.nama,
    required this.anggota,
  });
}

// =====================================================
// CLASS BARANG
// =====================================================

class Barang {
  String nama;
  int hargaAnggota;
  int hargaUmum;

  // Stok dibuat private agar tidak bisa diubah sembarangan
  int _stok;

  String kategori;

  Barang({
    required this.nama,
    required this.hargaAnggota,
    required this.hargaUmum,
    required int stok,
    required this.kategori,
  }) : _stok = stok;

  // Getter untuk membaca stok
  int get stok => _stok;

  // Method jual untuk mengurangi stok
  // Stok hanya akan berkurang jika jumlah yang diminta mencukupi.
  bool jual(int n) {
    if (n > 0 && n <= _stok) {
      _stok -= n;
      return true;
    }

    return false;
  }

  void tampilkan() {
    print("Nama Barang   : $nama");
    print("Harga Anggota : Rp${rupiah.format(hargaAnggota)}");
    print("Harga Umum    : Rp${rupiah.format(hargaUmum)}");
    print("Jumlah Stok   : $stok");
    print("Kategori      : $kategori");
    print("Status        : ${stok > 0 ? "Tersedia" : "Habis"}");
  }

  double nilaiStok() {
    return hargaUmum.toDouble() * stok;
  }

  // Method untuk mengecek apakah barang masih bisa dijual
  // berdasarkan jumlah yang diminta dan stok yang tersedia.
  bool bisaDijual(int diminta) {
    return diminta > 0 && diminta <= stok;
  }
}

// =====================================================
// CLASS BARANG PROMO
// =====================================================

class BarangPromo extends Barang {
  double diskon;

  BarangPromo({
    required String nama,
    required int hargaAnggota,
    required int hargaUmum,
    required int stok,
    required String kategori,
    required this.diskon,
  }) : super(
          nama: nama,
          hargaAnggota: hargaAnggota,
          hargaUmum: hargaUmum,
          stok: stok,
          kategori: kategori,
        );

  // Menghitung harga setelah mendapatkan diskon
  double hargaPromo() {
    return hargaUmum - (hargaUmum * diskon / 100);
  }
}

// =====================================================
// FUNGSI
// =====================================================

double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

double hitungHargaAkhir(double total, double persenPotongan) {
  return total - (total * persenPotongan / 100);
}

// =====================================================
// PROGRAM UTAMA
// =====================================================

void main() {
  // ===================================================
  // 1. MEMBUAT OBJEK BARANG
  // ===================================================

  Barang bukuTulis = Barang(
    nama: "Buku Tulis",
    hargaAnggota: 4500,
    hargaUmum: 5000,
    stok: 100,
    kategori: "atk",
  );

  Barang pulpen = Barang(
    nama: "Pulpen",
    hargaAnggota: 2000,
    hargaUmum: 2500,
    stok: 50,
    kategori: "atk",
  );

  Barang roti = Barang(
    nama: "Roti",
    hargaAnggota: 4500,
    hargaUmum: 5000,
    stok: 30,
    kategori: "makanan",
  );

  // ===================================================
  // 2. MEMBUAT OBJEK BARANG PROMO
  // ===================================================

  BarangPromo promo = BarangPromo(
    nama: "Buku Tulis Promo",
    hargaAnggota: 4500,
    hargaUmum: 5000,
    stok: 20,
    kategori: "atk",
    diskon: 20,
  );

  print("\n========================================");
  print("           BARANG PROMO");
  print("========================================");
  print("Nama Barang : ${promo.nama}");
  print("Harga Asli  : Rp${rupiah.format(promo.hargaUmum)}");
  print("Diskon      : ${promo.diskon}%");
  print("Harga Promo : Rp${rupiah.format(promo.hargaPromo())}");

  // ===================================================
  // 3. LIST BARANG
  // ===================================================

  List<Barang> daftarBarang = [
    bukuTulis,
    pulpen,
    roti,
  ];

  print("\n========================================");
  print("             DAFTAR BARANG");
  print("========================================");

  // Menampilkan semua barang menggunakan perulangan
  for (Barang barang in daftarBarang) {
    barang.tampilkan();
    print("Nilai Stok    : Rp${rupiah.format(barang.nilaiStok())}");
    print("----------------------------------------");
  }

  print("\n========================================");
  print("         CEK KETERSEDIAAN PENJUALAN");
  print("========================================");

  int jumlahDiminta = 20;

  print("Barang       : ${bukuTulis.nama}");
  print("Stok         : ${bukuTulis.stok}");
  print("Diminta      : $jumlahDiminta pcs");
  print(
    "Bisa Dijual  : ${bukuTulis.bisaDijual(jumlahDiminta) ? "Ya" : "Tidak"}",
  );

  // ===================================================
  // ENKAPSULASI - TEST JUAL
  // ===================================================

  print("\n========================================");
  print("           TEST ENKAPSULASI");
  print("========================================");

  print("Stok awal    : ${bukuTulis.stok}");

  bool penjualan1 = bukuTulis.jual(20);

  print(
    "Jual 20 pcs  : ${penjualan1 ? "Berhasil" : "Gagal"}",
  );
  print("Stok sekarang: ${bukuTulis.stok}");

  bool penjualan2 = bukuTulis.jual(200);

  print(
    "Jual 200 pcs : ${penjualan2 ? "Berhasil" : "Gagal"}",
  );
  print("Stok sekarang: ${bukuTulis.stok}");

  // Perbandingan dengan cara Sprint 3:
  // Pada Sprint 3, data barang masih disimpan dalam
  // List yang terpisah seperti List untuk nama
  // dan List untuk harga.
  //
  // Sekarang menggunakan List<Barang>, sehingga data
  // nama, harga, stok, dan kategori berada dalam satu objek.
  // Cara ini lebih rapi dan mudah dikelola.
  //
  // Jika barang bertambah, cukup membuat objek Barang baru
  // kemudian memasukkannya ke dalam List. Tidak perlu
  // membuat List terpisah atau menampilkan barang satu per satu.

  // ===================================================
  // 4. PERHITUNGAN OPERATOR
  // ===================================================

  int jumlah = 3;

  double totalAnggota = hitungTotal(
    jumlah,
    bukuTulis.hargaAnggota.toDouble(),
  );

  double totalUmum = hitungTotal(
    jumlah,
    bukuTulis.hargaUmum.toDouble(),
  );

  double selisih = totalUmum - totalAnggota;

  print("\n========================================");
  print("        PERHITUNGAN OPERATOR");
  print("========================================");

  print("Jumlah Beli     : $jumlah pcs");
  print("Total Anggota   : Rp${rupiah.format(totalAnggota)}");
  print("Total Umum      : Rp${rupiah.format(totalUmum)}");
  print("Selisih         : Rp${rupiah.format(selisih)}");

  // ===================================================
  // 5. TRANSAKSI & DISKON
  // ===================================================

  bool anggota = true;
  int jumlahBeli = 40;

  int harga;

  if (anggota) {
    harga = bukuTulis.hargaAnggota;
  } else {
    harga = bukuTulis.hargaUmum;
  }

  double totalTransaksi = hitungTotal(
    jumlahBeli,
    harga.toDouble(),
  );

  double persenPotongan;

  if (totalTransaksi > 200000) {
    persenPotongan = 10;
  } else if (totalTransaksi > 100000) {
    persenPotongan = 5;
  } else {
    persenPotongan = 0;
  }

  double hargaAkhir = hitungHargaAkhir(
    totalTransaksi,
    persenPotongan,
  );

  double potongan = totalTransaksi - hargaAkhir;

  print("\n========================================");
  print("         TRANSAKSI PEMBELIAN");
  print("========================================");

  print("Status Anggota : ${anggota ? "Ya" : "Tidak"}");
  print("Harga Dipakai  : Rp${rupiah.format(harga)}");
  print("Jumlah Beli    : $jumlahBeli pcs");
  print("Total Belanja  : Rp${rupiah.format(totalTransaksi)}");
  print("Potongan       : Rp${rupiah.format(potongan)}");
  print("Harga Akhir    : Rp${rupiah.format(hargaAkhir)}");

  // ===================================================
  // 6. SWITCH CASE KATEGORI
  // ===================================================

  String kategori = bukuTulis.kategori;
  String rak;

  switch (kategori) {
    case "atk":
      rak = "Rak 1";
      break;

    case "makanan":
      rak = "Rak 2";
      break;

    case "minuman":
      rak = "Rak 3";
      break;

    default:
      rak = "Rak lain";
  }

  print("\n========================================");
  print("          KATEGORI BARANG");
  print("========================================");

  print("Kategori : $kategori");
  print("Letak Rak: $rak");

  // ===================================================
  // 7. WHILE - PENJUALAN BARANG
  // ===================================================

  print("\n========================================");
  print("         PENJUALAN BUKU TULIS");
  print("========================================");

  while (bukuTulis.stok > 0) {
    bool berhasil = bukuTulis.jual(1);

    if (berhasil) {
      print("Terjual 1 pcs | Sisa stok: ${bukuTulis.stok}");
    }
  }

  print("----------------------------------------");
  print("Penjualan berhenti karena stok habis.");

  // ===================================================
  // JALANKAN FLUTTER
  // ===================================================

  runApp(const MyApp());
}

// =====================================================
// FLUTTER APP
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

// =====================================================
// HALAMAN UTAMA
// =====================================================

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// hots 1
// Method nilaiStok() digunakan untuk menghitung nilai seluruh stok barang
// berdasarkan harga umum dikalikan dengan jumlah stok.
// Nilai ini berguna untuk mengetahui perkiraan nilai aset barang
// yang masih dimiliki koperasi dan dapat digunakan dalam laporan aset.

// hots 2
// Pengecekan diletakkan di dalam objek Barang agar aturan
// penjualan dan stok menjadi tanggung jawab Barang itu sendiri.
// Dengan begitu, setiap barang dapat mengecek stoknya sendiri,
// kode lebih rapi, mudah digunakan kembali, dan mengurangi
// pengulangan pengecekan di bagian program lain.

// hots 3
// Relasi Pembeli dan Barang dalam transaksi adalah "membeli".
// Satu Pembeli dapat membeli satu atau lebih Barang dalam satu transaksi.
// Pembeli dan Barang tetap menjadi objek yang berdiri sendiri,
// sedangkan transaksi menjadi penghubung antara Pembeli dan Barang.

// hots enkapsulasi
// Enkapsulasi mencegah stok diubah sembarangan dengan menjadikan
// variabel stok sebagai private (_stok). Stok tidak dapat diubah
// secara langsung dari luar class, tetapi hanya dapat dikurangi
// melalui method jual(int n). Method jual() akan mengecek apakah
// jumlah stok mencukupi sebelum mengurangi stok.

// Justifikasi
// Melindungi _stok penting bagi integritas data koperasi karena
// stok tidak dapat diubah sembarangan dari luar class.
// Perubahan stok hanya dilakukan melalui method jual() yang
// melakukan pengecekan terlebih dahulu. Dengan begitu, data stok
// tetap akurat, konsisten, dan sesuai dengan transaksi penjualan.