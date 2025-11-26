import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:async'; // Tidak diperlukan karena sudah ada Future

// --- 1. MODEL DATA (Province & City) ---

// Model untuk data Provinsi
class Province {
  final String id;
  final String name;

  Province({
    required this.id,
    required this.name,
  });
}

// Model untuk data Kota/Kabupaten
class City {
  final String id;
  final String idProvinsi;
  final String name;

  City({
    required this.id,
    required this.idProvinsi,
    required this.name,
  });
}

// --- 2. PLACEHOLDER UNTUK DEPENDENSI EKSTERNAL (DropdownSearch & Mode) ---

enum Mode { DIALOG, MENU, BOTTOM_SHEET }

// Placeholder minimal untuk DropdownSearch yang meniru struktur yang terlihat di gambar.
// Dalam aplikasi nyata, ini adalah widget dari paket 'dropdown_search'.
class DropdownSearch<T> extends StatelessWidget {
  final T? selectedItem;
  final Function(T?)? onChanged;
  final Future<List<T>> Function(String)? onFind;
  final Widget Function(BuildContext, T?, bool)? dropdownBuilder;
  final Widget Function(BuildContext, T, bool)? popupItemBuilder;
  final bool showSearchBox;
  final Mode mode;

  const DropdownSearch({
    super.key,
    this.selectedItem,
    this.onChanged,
    this.onFind,
    this.dropdownBuilder,
    this.popupItemBuilder,
    this.showSearchBox = false,
    this.mode = Mode.DIALOG,
  });

  @override
  Widget build(BuildContext context) {
    // Implementasi minimalis untuk demonstrasi.
    // Dalam implementasi aslinya, ini adalah tombol yang memicu pencarian (onFind).
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: InkWell(
        onTap: () async {
          // Simulasi panggilan onFind saat diklik
          if (onFind != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Memuat data...'))
            );
            List<T> results = await onFind!('');
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Data berhasil dimuat: ${results.length} item.'))
            );
            // Implementasi nyata akan menampilkan dialog dengan hasil
          }
        },
        child: dropdownBuilder != null
            ? dropdownBuilder!(context, selectedItem, false)
            : Text(selectedItem.toString()),
      ),
    );
  }
}

// --- 3. WIDGET UTAMA (HomePage) ---

class HomePage extends StatefulWidget {
  // idProvinsi dari argumen constructor (dibiarkan opsional)
  final String? idProvinsi;

  // Api key yang terlihat di gambar pertama
  final String finalApiKey = "0c2d6e16b9a44ca9a56ae1e77ab47468583c8af18e72fddd55876c4820d08";

  const HomePage({super.key, this.idProvinsi});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // State untuk menyimpan ID Provinsi terpilih dan objek terpilih
  String? idProv;
  Province? selectedProvince;
  City? selectedCity;

  @override
  void initState() {
    super.initState();
    // Menginisialisasi idProv dari constructor jika ada
    idProv = widget.idProvinsi;
  }

  // --- Fungsi Pencarian Provinsi (Gambar 1) ---
  Future<List<Province>> findProvince(String text) async {
    print("CHECK ID PROVINSI: ${widget.idProvinsi}");
    print("CHECK ID PROVINSI: $idProv");

    try {
      // URL API untuk daftar provinsi
      var response = await http.get(Uri.parse(
          "https://api.binderbyte.com/wilayah/provinsi?api_key=${widget.finalApiKey}"
      ));

      if (response.statusCode == 200) {
        // Mengambil array 'value'
        List<dynamic> listProvinceJson = json.decode(response.body)['value'];
        List<Province> allModelProvince = [];

        // Iterasi dan konversi ke models Province
        listProvinceJson.forEach((element) {
          allModelProvince.add(
              Province(
                id: element["id"],
                name: element["name"],
              )
          );
        });
        return allModelProvince;
      } else {
        print("Error fetching provinces: Status Code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error during findProvince API call: $e");
      return [];
    }
  }

  // --- Fungsi Pencarian Kota/Kabupaten (Gambar 2) ---
  Future<List<City>> findCity(String text) async {
    print("CHECK ID PROVINSI:");
    print(idProv);

    if (idProv == null || idProv!.isEmpty) {
      // Return list kosong jika idProv belum terpilih
      return [];
    }

    try {
      // URL API untuk daftar kota/kabupaten, menggunakan idProv yang terpilih
      var response = await http.get(Uri.parse(
          "https://api.binderbyte.com/wilayah/kabupaten?api_key=${widget.finalApiKey}&id_provinsi=$idProv"
      ));

      if (response.statusCode == 200) {
        // Mengambil array 'value'
        List<dynamic> listCityJson = json.decode(response.body)['value'];
        List<City> allModelCity = [];

        // Iterasi dan konversi ke models City
        listCityJson.forEach((element) {
          allModelCity.add(
              City(
                  id: element["id"],
                  idProvinsi: element["id_provinsi"],
                  name: element["name"]
              )
          );
        });
        return allModelCity;
      } else if (response.statusCode == 400 && response.body.contains("id_provinsi tidak ditemukan")) {
        print("ID Provinsi tidak valid atau tidak ada kota/kabupaten.");
        return [];
      }
      else {
        print("Error fetching cities: Status Code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error during findCity API call: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WILAYAH INDONESIA"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          // DropdownSearch untuk Provinsi (Gambar Pertama)
          Text('Pilih Provinsi:', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownSearch<Province>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            selectedItem: selectedProvince,
            // Logika onChanged dari gambar pertama
            onChanged: (value) {
              setState(() {
                selectedProvince = value;
                // Update idProv yang akan digunakan untuk mencari kota
                idProv = value?.id;
                // Reset kota
                selectedCity = null;
              });
              // Simulasi log print(value)
              print('value -> ${value?.name} (ID: ${value?.id})');
            },
            // Logika dropdownBuilder dari gambar pertama
            dropdownBuilder: (context, selectedItem, bool) => Text(
                selectedItem?.name ?? "Belum memilih provinsi"
            ),
            // Logika popupItemBuilder dari gambar pertama
            popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item.name)
            ),
            // Logika onFind dari gambar pertama
            onFind: (text) => findProvince(text),
          ),

          // Sized Box (Gambar Pertama)
          const SizedBox(height: 20),

          // DropdownSearch untuk Kota/Kabupaten (Gambar Kedua)
          Text('Pilih Kota/Kabupaten:', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownSearch<City>(
            mode: Mode.DIALOG,
            showSearchBox: true,
            selectedItem: selectedCity,
            // Logika onChanged dari gambar kedua
            onChanged: (value) {
              setState(() {
                selectedCity = value;
              });
              // Simulasi log print(value.toJson())
              print('value.toJson() -> ${value?.name} (ID: ${value?.id})');
            },
            // Logika dropdownBuilder dari gambar kedua
            dropdownBuilder: (context, selectedItem, bool) => Text(
                selectedItem?.name ?? "Belum memilih kota/kabupaten"
            ),
            // Logika popupItemBuilder dari gambar kedua
            popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item.name)
            ),
            // Logika onFind dari gambar kedua
            onFind: (text) => findCity(text),
          ),

          // Sized Box (Gambar Kedua)
          const SizedBox(height: 20),

          if (selectedProvince != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Provinsi Terpilih: ${selectedProvince!.name} (ID: ${selectedProvince!.id})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          if (selectedCity != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Kota/Kabupaten Terpilih: ${selectedCity!.name} (ID: ${selectedCity!.id})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}

// Fungsi main untuk menjalankan aplikasi
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wilayah Indonesia App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
