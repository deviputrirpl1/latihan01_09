import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// Bahaya jika kondisi while keliru:
// Program bisa terus berjalan tanpa berhenti (infinite loop)
// atau stok menjadi minus karena penjualan tetap dilakukan
// meskipun barang sudah habis.

// Cara memastikan koperasi tidak menjual melebihi stok:
// Gunakan kondisi while (stokBuku > 0) sehingga penjualan
// hanya berlangsung selama stok masih tersedia dan berhenti
// tepat saat stok mencapai 0.

void main() {
   // ============================
  // DATA BARANG
  // ============================
  String namaBarang = "Buku Tulis";
  int hargaAnggota = 4500;
  int hargaUmum = 5000;
  int jumlahStok = 100;
  bool tersedia = jumlahStok > 0;

  final rupiah = NumberFormat('#,###', 'id_ID');

  print("=================================");
  print("      KARTU DATA BARANG");
  print("=================================");
  print("Nama Barang   : $namaBarang");
  print("Harga Anggota : Rp${rupiah.format(hargaAnggota)}");
  print("Harga Umum    : Rp${rupiah.format(hargaUmum)}");
  print("Jumlah Stok   : $jumlahStok");
  print("Status        : ${tersedia ? "Tersedia" : "Habis"}");

  // ============================
  // PERHITUNGAN OPERATOR
  // ============================
  int jumlah = 3;
  int totalAnggota = jumlah * hargaAnggota;
  int totalUmum = jumlah * hargaUmum;
  int selisih = totalUmum - totalAnggota;

  print("\n=================================");
  print("      PERHITUNGAN OPERATOR");
  print("=================================");
  print("Jumlah Beli         : $jumlah pcs");
  print("Total (Anggota)     : Rp${rupiah.format(totalAnggota)}");
  print("Total (Umum)        : Rp${rupiah.format(totalUmum)}");
  print("Selisih vs Umum     : Rp${rupiah.format(selisih)}");

  // ============================
  // IF ELSE & DISKON
  // ============================
  bool anggota = true;
  int jumlahBeli = 40;

  int harga;

  if (anggota) {
    harga = hargaAnggota;
  } else {
    harga = hargaUmum;
  }

  int total = jumlahBeli*harga;
  double potongan = 0;

  if (total > 200000) {
    potongan = total * 0.10;
  } else if (total > 100000) {
    potongan = total * 0.05;
  } else {
    potongan = 0;
  }

  double hargaAkhir = total - potongan;

  print("\n=================================");
  print("     TRANSAKSI PEMBELIAN");
  print("=================================");
  print("Status Anggota : ${anggota ? "Ya" : "Tidak"}");
  print("Harga Dipakai  : Rp${rupiah.format(harga)}");
  print("Jumlah Beli    : $jumlahBeli pcs");
  print("Total Belanja  : Rp${rupiah.format(total)}");
  print("Potongan       : Rp${rupiah.format(potongan)}");
  print("Harga Akhir    : Rp${rupiah.format(hargaAkhir)}");

 // ============================
// SWITCH CASE
// ============================

String kategori = "atk";
String rak;

// Switch-case lebih rapi karena hanya mengecek
// satu variabel (kategori) dengan beberapa pilihan nilai.
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

print("\n=================================");
print("     KATEGORI BARANG");
print("=================================");
print("Kategori      : $kategori");
print("Letak Rak     : $rak");

// ============================
// DAFTAR BARANG
// ============================

List<String> daftarBarang = [
  "Buku Tulis",
  "Pulpen",
  "Penghapus",
  "Roti"
];

List<int> daftarHarga = [
  3000,
  2500,
  1500,
  5000
];

print("\n=================================");
print("       DAFTAR BARANG");
print("=================================");

for (int i = 0; i < daftarBarang.length; i++) {
  print("${i + 1}. ${daftarBarang[i]} - Rp${rupiah.format(daftarHarga[i])}");
}

// ============================
// WHILE - PENJUALAN BARANG
// ============================

int stokBuku = 3;

print("\n=================================");
print("   PENJUALAN BUKU TULIS");
print("=================================");

while (stokBuku > 0) {
  stokBuku--;
  print("Terjual 1, sisa stok: $stokBuku");
}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
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

