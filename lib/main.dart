import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final rupiah = NumberFormat('#,###', 'id_ID');

// =====================================================
// CLASS PEMBELI
// =====================================================

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
  int _stok;
  String kategori;

  Barang({
    required this.nama,
    required this.hargaAnggota,
    required this.hargaUmum,
    required int stok,
    required this.kategori,
  }) : _stok = stok;

  // Getter stok
  int get stok => _stok;

  // Method untuk proses penjualan
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

  double hargaPromo() {
    return hargaUmum - (hargaUmum * diskon / 100);
  }

  @override
  void tampilkan() {
    print("Nama Barang   : $nama");
    print("Status        : PROMO");
    print("Harga Coret   : Rp${rupiah.format(hargaUmum)}");
    print("Harga Promo   : Rp${rupiah.format(hargaPromo())}");
    print("Diskon        : $diskon%");
    print("Jumlah Stok   : $stok");
    print("Kategori      : $kategori");
  }
}

// =====================================================
// CLASS BARANG GROSIR
// =====================================================

class BarangGrosir extends Barang {
  double diskonGrosir;

  BarangGrosir({
    required String nama,
    required int hargaAnggota,
    required int hargaUmum,
    required int stok,
    required String kategori,
    required this.diskonGrosir,
  }) : super(
          nama: nama,
          hargaAnggota: hargaAnggota,
          hargaUmum: hargaUmum,
          stok: stok,
          kategori: kategori,
        );

  double hargaGrosir() {
    return hargaUmum - (hargaUmum * diskonGrosir / 100);
  }

  @override
  void tampilkan() {
    print("Nama Barang   : $nama");
    print("Status        : GROSIR");
    print("Harga Normal  : Rp${rupiah.format(hargaUmum)}");
    print("Harga Grosir  : Rp${rupiah.format(hargaGrosir())}");
    print("Diskon Grosir : $diskonGrosir%");
    print("Jumlah Stok   : $stok");
    print("Kategori      : $kategori");
  }
}

// =====================================================
// FUNGSI HITUNG TOTAL
// =====================================================

double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

double hitungHargaAkhir(
  double total,
  double persenPotongan,
) {
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
  // 2. BARANG PROMO
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
  print("             BARANG PROMO");
  print("========================================");

  promo.tampilkan();

  // ===================================================
  // 3. BARANG GROSIR
  // ===================================================

  BarangGrosir grosir = BarangGrosir(
    nama: "Buku Tulis Grosir",
    hargaAnggota: 4500,
    hargaUmum: 5000,
    stok: 50,
    kategori: "atk",
    diskonGrosir: 10,
  );

  print("\n========================================");
  print("             BARANG GROSIR");
  print("========================================");

  grosir.tampilkan();

  // ===================================================
  // 4. LIST BARANG
  // ===================================================

  List<Barang> daftarBarang = [
    bukuTulis,
    pulpen,
    roti,
  ];

  print("\n========================================");
  print("             DAFTAR BARANG");
  print("========================================");

  for (Barang barang in daftarBarang) {
    barang.tampilkan();

    print(
      "Nilai Stok    : Rp${rupiah.format(barang.nilaiStok())}",
    );

    print("----------------------------------------");
  }

  // ===================================================
  // 5. CEK KETERSEDIAAN
  // ===================================================

  int jumlahDiminta = 20;

  print("\n========================================");
  print("        CEK KETERSEDIAAN PENJUALAN");
  print("========================================");

  print("Barang       : ${bukuTulis.nama}");
  print("Stok         : ${bukuTulis.stok}");
  print("Diminta      : $jumlahDiminta pcs");

  print(
    "Bisa Dijual  : "
    "${bukuTulis.bisaDijual(jumlahDiminta) ? "Ya" : "Tidak"}",
  );

  // ===================================================
  // 6. TEST ENKAPSULASI
  // ===================================================

  print("\n========================================");
  print("            TEST ENKAPSULASI");
  print("========================================");

  print("Stok awal    : ${bukuTulis.stok}");

  // Uji perubahan stok
  bukuTulis._stok = 999;

  print(
    "Stok setelah diubah langsung: "
    "${bukuTulis.stok}",
  );

  bool penjualan1 = bukuTulis.jual(20);

  print(
    "Jual 20 pcs  : "
    "${penjualan1 ? "Berhasil" : "Gagal"}",
  );

  print("Stok sekarang: ${bukuTulis.stok}");

  bool penjualan2 = bukuTulis.jual(200);

  print(
    "Jual 200 pcs : "
    "${penjualan2 ? "Berhasil" : "Gagal"}",
  );

  print("Stok sekarang: ${bukuTulis.stok}");

  // ===================================================
  // 7. PERHITUNGAN OPERATOR
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
  print("         PERHITUNGAN OPERATOR");
  print("========================================");

  print("Jumlah Beli     : $jumlah pcs");
  print(
    "Total Anggota   : "
    "Rp${rupiah.format(totalAnggota)}",
  );

  print(
    "Total Umum      : "
    "Rp${rupiah.format(totalUmum)}",
  );

  print(
    "Selisih         : "
    "Rp${rupiah.format(selisih)}",
  );

  // ===================================================
  // 8. FUNGSI PROSES BELI
  // ===================================================

  void prosesBeli(String inputJumlah) {
    try {
      // Mengubah input String menjadi angka
      int jumlahBeli = int.parse(inputJumlah);

      // Proses penjualan
      bool berhasil = bukuTulis.jual(jumlahBeli);

      if (berhasil) {
        print("Penjualan berhasil.");
        print("Jumlah terjual: $jumlahBeli");
        print("Sisa stok: ${bukuTulis.stok}");
      } else {
        print("Penjualan gagal. Stok tidak mencukupi.");
      }
    } catch (e) {
      // Jika input bukan angka
      print(
        "Input jumlah tidak valid. "
        "Silakan masukkan angka dan coba lagi.",
      );
    } finally {
      // Selalu dijalankan
      print("Transaksi dicatat di log");
    }
  }

  // ===================================================
  // 9. TEST PROSES BELI
  // ===================================================

  print("\n========================================");
  print("           TEST PROSES BELI");
  print("========================================");

prosesBeli("2");
prosesBeli("dua");

  // ===================================================
  // 10. SWITCH CASE KATEGORI
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
  print("           KATEGORI BARANG");
  print("========================================");

  print("Kategori : $kategori");
  print("Letak Rak: $rak");

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
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium,
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