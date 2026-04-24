/*import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.subject,
    required super.dueDate,
    required super.status,
    super.imageUrl,
    required super.assignedTo,
    super.teacherName,
    super.teacherFeedback,
    super.progress,
    super.isDeleted
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      subject: json['subject'],
      dueDate: DateTime.parse(json['dueDate']),
      status: TaskStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => TaskStatus.pending,
      ),
      imageUrl: json['imageUrl'],
      assignedTo: json['assignedTo'],
      teacherName: json['teacherName'],
      teacherFeedback: json['teacherFeedback'],
      progress: json['progress']?.toDouble(),
      isDeleted: json['isDeleted'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subject': subject,
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
      'imageUrl': imageUrl,
      'assignedTo': assignedTo,
      'teacherName': teacherName,
      'teacherFeedback': teacherFeedback,
      'progress': progress,
      'isDeleted': isDeleted,
    };
  }
}*/
/*import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.subject,
    required super.dueDate,
    required super.status,
    super.imageUrl,
    required super.assignedTo,
    super.teacherName,
    super.teacherFeedback,
    super.progress,
    super.isDeleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      subject: json['subject'],
      dueDate: DateTime.parse(json['dueDate']),
      status: (json['state'] == "Completed")
          ? TaskStatus.completed
          : TaskStatus.pending,
      assignedTo: json['classId'].toString(),
      teacherName: json['teacherId']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "subject": subject,
      "dueDate": dueDate.toIso8601String(),
      "classId": int.parse(assignedTo),
      "teacherId": int.parse(teacherName!),
      "state": status == TaskStatus.completed ? "Completed" : "Pending",
    };
  }
}*/
/*import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends Task {
  // Fields matching the Backend 'Assignment' class
  final int? semesterId;

  TaskModel({
    required super.id, // نحول الـ int جاي من الباك لـ String عشان الـ Entity
    required super.title,
    required super.description,
    required super.subject,
    required super.dueDate,
    required super.status,
    super.imageUrl,
    required super.assignedTo, // هنا نخزن classId كـ String
    super.teacherName, // هنا نخزن teacherId كـ String
    this.semesterId,
  });

  // Mapping from JSON (Backend) to Model
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      subject: json['subject'] ?? "General", // الباك مبيجبش Subject في الجدول اللي ابعتته، حطيت قيمة افتراضية
      dueDate: DateTime.parse(json['deadLine'] ?? json['dueDate'] ?? DateTime.now().toIso8601String()),
      status: (json['state']?.toString().toLowerCase() == "completed" || json['state']?.toString().toLowerCase() == "done")
          ? TaskStatus.completed
          : TaskStatus.pending,
      assignedTo: json['classId']?.toString() ?? "0",
      teacherName: json['teacherId']?.toString() ?? "0",
      semesterId: json['semesterId'],
    );
  }

  // Mapping from Model to JSON (Backend)
  Map<String, dynamic> toJson() {
    return {
      // نرجع القيم لنوعها الصحيح للباك إند
      "id": int.tryParse(id) ?? 0,
      "title": title,
      "description": description,
      "subject": subject,
      "deadLine": dueDate.toIso8601String(),
      "state": status == TaskStatus.completed ? "Completed" : "Pending",
      "classId": int.tryParse(assignedTo) ?? 0,
      "teacherId": int.tryParse(teacherName ?? "0") ?? 0,
      "semesterId": semesterId ?? 0,
    };
  }
}*/
/*import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class TaskModel extends Task {
  final int? semesterId;

  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.subject,
    required super.dueDate,
    required super.status,
    super.imageUrl,
    required super.assignedTo,
    super.teacherName,
    this.semesterId,
  });

  // ================= FROM JSON =================
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      subject: json['subject'] ?? "General",
      dueDate: DateTime.parse(
        json['deadLine'] ??
            json['dueDate'] ??
            DateTime.now().toIso8601String(),
      ),
      status: (json['state']?.toString().toLowerCase() == "completed" ||
          json['state']?.toString().toLowerCase() == "done")
          ? TaskStatus.completed
          : TaskStatus.pending,
      assignedTo: json['classId']?.toString() ?? "0",
      teacherName: json['teacherId']?.toString() ?? "0",
      semesterId: json['semesterId'],
    );
  }

  // ================= TO JSON =================
  Map<String, dynamic> toJson() {
    return {

      "title": title,
      "description": description,
      "deadLine": dueDate.toIso8601String(),
      "state": status == TaskStatus.completed ? "Completed" : "Pending",

      "classId": int.tryParse(assignedTo) ?? 0,
      "teacherId": int.tryParse(teacherName ?? "0") ?? 0,
      "semesterId": semesterId ?? 0,
    };
  }
}*/
// task_model.dart
/*import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TaskModel extends Task {
  final int? semesterId;

  TaskModel({
    // تعديل هنا: بنستخدم super.id ولكن الـ Model في جوهره يعتمد على الباك
    required super.id, // super.id هو String
    required super.title,
    required super.description,
    required super.subject, // مهم: تأكد إنك باعت المادة
    required super.dueDate,
    required super.status,
    super.imageUrl,
    required super.assignedTo,
    super.teacherName,
    this.semesterId,
  });

  // ================= FROM JSON =================
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id']?.toString() ?? "0", // تحويل الآيدي لـ String فوراً للعرض
      title: json['title'],
      description: json['description'],
      subject: json['subject'] ?? "General",
      dueDate: DateTime.parse(
        json['deadLine'] ??
            json['dueDate'] ??
            DateTime.now().toIso8601String(),
      ),
      status: (json['state']?.toString().toLowerCase() == "completed" ||
          json['state']?.toString().toLowerCase() == "done")
          ? TaskStatus.completed
          : TaskStatus.pending,
      assignedTo: json['classId']?.toString() ?? "0",
      teacherName: json['teacherId']?.toString() ?? "0",
      semesterId: json['semesterId'],
    );
  }

  // ================= TO JSON =================
  Map<String, dynamic> toJson() {
    return {
      // مهم جداً: لو الـ ID فاضي (تاسك جديد)، متبعتوش خلي السيرفر يولده
      // لو فيه ID (تعديل)، ابعته
      if (int.tryParse(id) != null && int.tryParse(id)! > 0) "id": int.parse(id),

      "title": title,
      "description": description,
      "deadLine": dueDate.toIso8601String(),
      "state": status == TaskStatus.completed ? "Completed" : "Pending",

      // إضافة حقل المادة ليتوافق مع الـ Entity
      "subject": subject,

      "classId": int.tryParse(assignedTo) ?? 0,
      "teacherId": int.tryParse(teacherName ?? "0") ?? 0,
      "semesterId": semesterId ?? 0,
    };
  }
}*/
import 'package:arak_app/features/tasks/domain/entities/task.dart';

class TaskModel extends Task {
  final int? semesterId;

  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.subject, // ده للعرض بس في الفرونت، مش بيتعمل له Mapping في الباك
    required super.dueDate,
    required super.status,
    super.imageUrl,
    required super.assignedTo,
    super.teacherName,
    super.teacherFeedback,
    super.progress,
    super.isDeleted,
    this.semesterId,
  });

  // ================= FROM JSON =================
  // ده الكود اللي يقرأ البيانات القادمة من الباك (Response)
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id']?.toString() ?? "0",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      subject: json['subject'] ?? "",
      dueDate: json['deadLine'] != null
          ? DateTime.parse(json['deadLine'])
          : DateTime.now(),
      status: (json['state']?.toString().toLowerCase() == "completed")
          ? TaskStatus.completed
          : TaskStatus.pending,
      assignedTo: json['classId']?.toString() ?? "",
      teacherName: json['teacherId']?.toString(),
      semesterId: json['semesterId'], // نحفظ القيمة لو جات، بس مش بنبعثها
    );
  }

  // ================= TO JSON =================
  // ده الكود اللي بيجهز البيانات عشان نبعتها للباك (Request)
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,

      // ملاحظة: الباك عنده deadLine و dueDate في الفرونت
      // فبنبعت dueDate.here (اسم بتاع الفرونت) كقيمة للمفتاح deadLine (بتاع الباك)
      "deadLine": dueDate.toIso8601String(),

      // الحالة: Pending or Completed
      "state": status == TaskStatus.completed ? "Completed" : "Pending",

      // الـ Class ID
      "classId": int.tryParse(assignedTo) ?? 0,

      // الـ Teacher ID (هيبقى 0 لو الفرونت مسكاه، والباك هيشوفه من التوكن)
      "teacherId": int.tryParse(teacherName ?? "") ?? 0,

      // ✅ تم حذف subject و semesterId عشان الباك مش محتاجهم
    };
  }
}
