import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
// Pastikan kedua file ini ada di folder lib Anda
import 'log_model.dart';
import 'log_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Log Explorer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LogExplorerScreen(),
    );
  }
}

class LogExplorerScreen extends StatefulWidget {
  const LogExplorerScreen({super.key});

  @override
  State<LogExplorerScreen> createState() => _LogExplorerScreenState();
}

class _LogExplorerScreenState extends State<LogExplorerScreen> {
  final LogStorage _storage = LogStorage();
  List<LogEntry> _logs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  // Mengakses File System untuk memuat log
  Future<void> _loadLogs() async {
    // Tidak perlu cek mounted di sini karena ini dipanggil di initState awal,
    // tapi good practice tetap mengecek jika ada delay sebelumnya.
    final loadedLogs = await _storage.loadLogs();

    if (!mounted) return; // SAFEGUARD

    setState(() {
      _logs = loadedLogs;
      _isLoading = false;
    });
  }

  // --- Fitur Location Services dan Camera ---
  Future<void> _createLog() async {
    // 1. Ambil Lokasi (Location Services)
    Position? position;
    try {
      // Cek izin dan layanan
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
          if (!mounted) return;
          _showSnackBar("Izin lokasi diperlukan untuk membuat log.");
          return;
        }
      }

      // Mengambil posisi bisa memakan waktu
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar("Gagal mendapatkan lokasi: $e");
      return;
    }

    // SAFEGUARD: Cek apakah user keluar dari layar saat menunggu lokasi
    if (!mounted) return;

    // 2. Ambil Foto (Camera/Image Picker)
    final ImagePicker picker = ImagePicker();
    XFile? photo;
    try {
      photo = await picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar("Gagal mengakses kamera: $e");
      return;
    }

    // SAFEGUARD LAGI: Cek mounted lagi setelah await kamera
    if (!mounted) return;

    if (photo == null || position == null) {
      _showSnackBar("Log dibatalkan.");
      return;
    }

    // 3. Buat Log Baru
    final newLog = LogEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
      latitude: position.latitude,
      longitude: position.longitude,
      imagePath: photo.path,
    );

    // 4. Simpan ke File System
    // Update list lokal dulu agar UI responsif, baru simpan ke storage
    setState(() {
      _logs.add(newLog);
    });

    // Simpan async di background, tidak perlu blocking UI kecuali krusial
    try {
      await _storage.saveLogs(_logs);
      if (mounted) {
        _showSnackBar("Log baru berhasil dibuat dan disimpan!");
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar("Gagal menyimpan data: $e");
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Log Explorer'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _logs.isEmpty
          ? const Center(child: Text("Tekan '+' untuk membuat log pertama Anda."))
          : ListView.builder(
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          final log = _logs[index];
          return LogCard(log: log);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createLog,
        tooltip: 'Buat Log Baru (Foto & Lokasi)',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

// Widget untuk menampilkan satu entri Log
class LogCard extends StatelessWidget {
  final LogEntry log;
  const LogCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID Log: ${log.id}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Waktu: ${log.timestamp}'),
            // Memperbaiki string interpolation yang terpotong baris
            Text(
              'Lokasi: Lat ${log.latitude.toStringAsFixed(4)}, Lon ${log.longitude.toStringAsFixed(4)}',
            ),
            const SizedBox(height: 8),
            // Menampilkan Gambar
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.file(
                File(log.imagePath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text("Foto tidak ditemukan"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}