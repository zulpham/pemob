import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'log_model.dart';
class LogStorage {
// 1. Mendapatkan referensi file lokal
  Future<File> get _localFile async {
// Menggunakan path_provider untuk mendapatkan direktori dokumen
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/device_logs.json');
  }
// 2. Memuat semua log dari file
  Future<List<LogEntry>> loadLogs() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return []; // Kembalikan list kosong jika file belum ada
      }
// Baca file sebagai String
      final contents = await file.readAsString();
// Decode String JSON menjadi List<Map>
      final List<dynamic> jsonList = jsonDecode(contents);
// Konversi List<Map> menjadi List<LogEntry>
      return jsonList.map((json) => LogEntry.fromJson(json)).toList();

    } catch (e) {
      print("Error memuat log: $e");
      return [];
    }
  }
// 3. Menyimpan list log ke file
  Future<File> saveLogs(List<LogEntry> logs) async {
// Konversi List<LogEntry> menjadi List<Map>
    final jsonList = logs.map((log) => log.toJson()).toList();
// Encode List<Map> menjadi String JSON
    final String contents = jsonEncode(jsonList);
    final file = await _localFile;
// Tulis String JSON ke file
    return file.writeAsString(contents);
  }
}