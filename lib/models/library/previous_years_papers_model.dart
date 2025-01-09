
class PreviousYearModel {
  final int? id;
  final String? courseId;
  final int? contentTypeId;
  final String? uniqueName;
  final String? fileName;
  final String? description;

  PreviousYearModel({
    this.id,
    this.courseId,
    this.contentTypeId,
    this.uniqueName,
    this.fileName,
    this.description,
  });

  factory PreviousYearModel.fromJson(Map<String, dynamic> json) {
    return PreviousYearModel(
      id: json['id'],
      courseId: json['course_id'],
      contentTypeId: json['content_type_id'],
      uniqueName: json['unique_name'],
      fileName: json['file_name'],
      description: json['description'],
    );
  }
}

