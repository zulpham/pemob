import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_task_controller.dart';

class AddTaskView extends GetView<AddTaskController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Tugas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                labelText: 'Judul Tugas',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.descriptionController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Simpan'),
              onPressed: controller.saveTask,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
