import 'package:get/get.dart';
import '../../../data/models/task_model.dart';

class TaskController extends GetxController {
  // Observable list untuk menyimpan tugas
  RxList<TaskModel> tasks = <TaskModel>[].obs;

  // Metode untuk menambah tugas baru (langsung TaskModel)
  void addTask(TaskModel task) {
    tasks.add(task);
  }

  // Metode untuk menghapus tugas
  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
  }

  // Metode untuk menandai tugas sebagai selesai/belum selesai
  void toggleTaskStatus(String id) {
    final index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index] = tasks[index].copyWith(
        isCompleted: !tasks[index].isCompleted,
      );
      tasks.refresh(); // pastikan UI ter-update
    }
  }

  // Metode untuk mendapatkan tugas berdasarkan ID
  TaskModel? getTaskById(String id) {
    return tasks.firstWhereOrNull((task) => task.id == id);
  }

  // Metode untuk mengedit tugas
  void editTask(String id, {String? title, String? description}) {
    final index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index] = tasks[index].copyWith(
        title: title ?? tasks[index].title,
        description: description ?? tasks[index].description,
      );
      tasks.refresh();
    }
  }

  // Getter untuk mendapatkan jumlah tugas
  int get totalTasks => tasks.length;

  // Getter untuk mendapatkan jumlah tugas yang sudah selesai
  int get completedTasks => tasks.where((task) => task.isCompleted).length;
}
