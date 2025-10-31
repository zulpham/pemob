import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hapus banner debug di kanan atas
      debugShowCheckedModeBanner: false,
      title: 'Contoh Dropdown Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  // Data statis yang akan ditampilkan di dropdown
  final List<Map<String, dynamic>> dataList = [
    {
      "country": "Brazil",
      "id": 1,
    },
    {
      "country": "Tunisia",
      "id": 2,
    },
    {
      "country": "Canada",
      "id": 3,
    },
    {
      "country": "India",
      "id": 4,
    },
    {
      "country": "Indonesia",
      "id": 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Menyiapkan nilai terpilih default
    final selectedItem = dataList[2]; // Canada

    return Scaffold(
      appBar: AppBar(
        title: Text("Contoh Dropdown"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: DropdownSearch<Map<String, dynamic>>(
          // Data yang akan ditampilkan dalam list (Statis/Lokal)
          items: dataList,

          // Item yang terpilih secara default
          selectedItem: selectedItem,

          // PERBAIKAN: Tambahkan compareFn untuk mengatasi Assertion Failed.
          // Fungsi ini membandingkan dua item (Map) berdasarkan kunci unik 'id'.
          compareFn: (item1, item2) => item1['id'] == item2['id'],

          // 1. Konfigurasi Pop-up
          popupProps: PopupProps.menu(
            showSearchBox: true,
            showSelectedItems: true,
            // Menggantikan 'popupItemBuilder'
            itemBuilder: (context, item, isSelected) {
              return ListTile(
                title: Text(item["country"].toString()),
                // Menandai item yang terpilih
                tileColor: isSelected ? Colors.red.shade100 : null,
                textColor: Colors.red,
              );
            },
          ),

          // 2. Konfigurasi Tampilan Dropdown
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              // Menggantikan logika 'dropdownBuilder' sederhana
              hintText: selectedItem?["country"]?.toString() ?? "Belum pilih negara",
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),


          // Label untuk item yang akan ditampilkan
          itemAsString: (Map<String, dynamic>? item) {
            return item?['country']?.toString() ?? 'Pilih Negara';
          },

          // Event ketika item dipilih
          onChanged: (value) => print(value?["id"] ?? null),
        ),
      ),
    );
  }
}
