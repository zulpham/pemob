import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init(); // Inisialisasi GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Storage Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Menyimpan data
                box.write('username', 'Flutter User');
                Get.snackbar("Data", "data disimpan");
              },
              child: Text("Simpan Data"),
            ),
            ElevatedButton(
              onPressed: () {
                // Mengambil data
                String username = box.read('username') ?? 'Tidak ada data';
                Get.snackbar("Data", username);
              },
              child: Text("Ambil Data"),
            ),
            ElevatedButton(
              onPressed: () {
                // Menghapus data
                box.remove('username');
                Get.snackbar("Data", "data dihapus");
              },
              child: Text("Hapus Data"),
            ),
          ],
        ),
      ),
    );
  }
}
