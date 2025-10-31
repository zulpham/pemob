import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';

// --- PERBAIKAN 1: SINTAKS KONSTRUKTOR ---
// 'const ({super.key});' tidak valid, seharusnya:
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // --- PERBAIKAN 2: SINTAKS createSate ---
  // Nama State harus 'State<HomePage>' dan class-nya '_HomePageState'
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // --- PERBAIKAN 3: LOGIKA STATE & DATA ---
  // Pindahkan 'faker' dan data ke dalam state yang diinisialisasi satu kali.
  // Kita buat List untuk menampung data yang akan ditampilkan.
  final List<_ItemData> _items = [];
  final _faker = Faker();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Hasilkan data palsu satu kali saja saat widget pertama kali dibuat.
    // Mari kita buat 50 item data palsu.
    for (var i = 0; i < 50; i++) {
      _items.add(
        _ItemData(
          name: _faker.person.name(),
          imageUrl: "https://picsum.photos/id/${870 + i}/200/300",
          // Gunakan faker untuk tanggal yang bervariasi agar lebih realistis
          timestamp: _faker.date.dateTime(minYear: 2024, maxYear: 2025),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Daftar widget untuk body, sesuai dengan tab yang dipilih
    final List<Widget> widgets = [
      ListView.builder(
        // --- PERBAIKAN 4: GUNAKAN DATA DARI STATE ---
        itemCount: _items.length, // Tentukan jumlah item
        itemBuilder: (context, index) {
          // Ambil data item dari list yang sudah kita buat di initState
          final item = _items[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(item.imageUrl), // Gunakan data
            ),
            title: Text(item.name), // Gunakan data
            subtitle: Text(
              // Format tanggal unik untuk setiap item
              DateFormat.yMMMMEEEEd().add_jm().format(item.timestamp),
            ),
          );
        },
      ),
      // Gunakan 'const' untuk widget statis agar performa lebih baik
      const Center(
        child: Text("MENU KE 2"),
      ),
      const Center(
        child: Text("MENU KE 3"),
      ),
      const Center(
        child: Text("MENU KE 4"),
      ),
      const Center(
        child: Text("MENU KE 5"),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("FAKER"), // Gunakan const
      ),
      body: widgets[currentIndex], // Tampilkan widget berdasarkan index
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.red[900],
        // Gunakan 'const' untuk list item yang statis
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
          // Update state saat tab diganti
          setState(() {
            currentIndex = i;
          });
        },
      ),
    );
  }
}

// Class helper sederhana untuk menyimpan data item
// Ini jauh lebih rapi daripada menggunakan Map
class _ItemData {
  final String name;
  final String imageUrl;
  final DateTime timestamp;

  _ItemData({
    required this.name,
    required this.imageUrl,
    required this.timestamp,
  });
}
