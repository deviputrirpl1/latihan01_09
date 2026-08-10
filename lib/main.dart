import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// =====================================================
// FORMAT RUPIAH
// =====================================================

final rupiah = NumberFormat('#,###', 'id_ID');

// =====================================================
// CLASS BARANG
// =====================================================

class Barang {
  // Atribut
  String nama;
  int hargaAnggota;
  int hargaUmum;
  int stok;
  String kategori;

  // Konstruktor
  Barang({
    required this.nama,
    required this.hargaAnggota,
    required this.hargaUmum,
    required this.stok,
    required this.kategori,
  });

  // Method untuk menampilkan informasi barang
  void tampilkan() {
    print("Nama Barang   : $nama");
    print("Harga Anggota : Rp${rupiah.format(hargaAnggota)}");
    print("Harga Umum    : Rp${rupiah.format(hargaUmum)}");
    print("Jumlah Stok   : $stok");
    print("Kategori      : $kategori");
    print("Status        : ${stok > 0 ? "Tersedia" : "Habis"}");
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
  // DATA BARANG
  // ===================================================

  print("\n========================================");
  print("             DATA BARANG");
  print("========================================");

  print("\n[Barang 1]");
  bukuTulis.tampilkan();

  print("----------------------------------------");

  print("[Barang 2]");
  pulpen.tampilkan();

  print("----------------------------------------");

  print("[Barang 3]");
  roti.tampilkan();

  // ===================================================
  // 2. PERHITUNGAN OPERATOR
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
  // 3. TRANSAKSI & DISKON
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
  // 4. SWITCH CASE KATEGORI
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
  // 5. DAFTAR BARANG
  // ===================================================

  List<String> daftarBarang = [
    "Buku Tulis",
    "Pulpen",
    "Penghapus",
    "Roti",
  ];

  List<int> daftarHarga = [
    3000,
    2500,
    1500,
    5000,
  ];

  print("\n========================================");
  print("            DAFTAR BARANG");
  print("========================================");

  for (int i = 0; i < daftarBarang.length; i++) {
    print(
      "${i + 1}. ${daftarBarang[i]} "
      "- Rp${rupiah.format(daftarHarga[i])}",
    );
  }

  // ===================================================
  // 6. WHILE - PENJUALAN BARANG
  // ===================================================

  int stokBuku = 3;

  print("\n========================================");
  print("         PENJUALAN BUKU TULIS");
  print("========================================");

  while (stokBuku > 0) {
    stokBuku--;

    print(
      "Terjual 1 pcs | Sisa stok: $stokBuku",
    );
  }

  print("----------------------------------------");
  print("Penjualan berhenti karena stok habis.");

  runApp(const MyApp());
}


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