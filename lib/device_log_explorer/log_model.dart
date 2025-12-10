import 'dart:convert';
class LogEntry {
  final String id;
  final String timestamp;
  final double latitude;
  final double longitude;
  final String imagePath; // Path lokal tempat foto disimpan
  LogEntry({
    required this.id,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.imagePath,
  });
// Konversi dari Map (digunakan saat memuat dari file)
  factory LogEntry.fromJson(Map<String, dynamic> json) {

    return LogEntry(
      id: json['id'] as String,
      timestamp: json['timestamp'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      imagePath: json['imagePath'] as String,
    );
  }
// Konversi ke Map (digunakan saat menyimpan ke file)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp,
      'latitude': latitude,
      'longitude': longitude,
      'imagePath': imagePath,
    };
  }
}