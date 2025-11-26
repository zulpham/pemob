import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../add_task/views/add_task_view.dart';

class HomeView extends GetView<TaskController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
        centerTitle: true,
        actions: [
          Obx(() => Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                '${controller.completedTasks}/${controller.totalTasks}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )),
        ],
      ),
      body: Obx(() => ListView.builder(
        itemCount: controller.tasks.length,
        itemBuilder: (context, index) {
          final task = controller.tasks[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(task.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) =>
                      controller.toggleTaskStatus(task.id),
                ),
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) =>
                      controller.toggleTaskStatus(task.id),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.deleteTask(task.id),
                ),
              ],
            ),
            onTap: () =>
                Get.toNamed('/task-detail', arguments: task),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.toNamed('/add-task'),
      ),
    );
  }
}
