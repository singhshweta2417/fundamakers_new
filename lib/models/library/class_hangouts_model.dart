
class ClassHangOutsModel {
  final int? id;
  final String? courseId;
  final int? subjectId;
  final String? description;
  final String? uniqueName;
  final String? fileName;
  final String? filePath;
  final String? host;

  ClassHangOutsModel({
    this.id,
    this.courseId,
    this.subjectId,
    this.description,
    this.uniqueName,
    this.fileName,
    this.filePath,
    this.host,
  });

  factory ClassHangOutsModel.fromJson(Map<String, dynamic> json) {
    return ClassHangOutsModel(
      id: json['id'],
      courseId: json['course_id'],
      subjectId: json['subject_id'],
      description: json['description'],
      uniqueName: json['unique_name'],
      fileName: json['file_name'],
      filePath: json['file_path'],
      host: json['host'],
    );
  }
}

