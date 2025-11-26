import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/task_controller.dart';
import '../../../../data/models/task_model.dart';

class AddTaskController extends GetxController {
  // Controller untuk input form
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // Method untuk menyimpan tugas baru
  void saveTask() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty) {
      Get.snackbar('Error', 'Judul tugas tidak boleh kosong');
      return;
    }

    // Buat model tugas baru
    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      isCompleted: false,
    );

    // Tambahkan ke TaskController
    final taskController = Get.find<TaskController>();
    taskController.addTask(newTask);

    // Kembali ke halaman sebelumnya
    Get.back();
  }

  @override
  void onClose() {
    // Pastikan TextEditingController dibersihkan
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
