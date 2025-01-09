
class MainTestListModel {
  final int? id;
  final int? courseId;
  final int? testTypeId;
  final String? name;
  final int? hasWindowTimeLimit;
  final String? fromDate;
  final String? toDate;
  final int? cutOffMarks;
  final int? status;
  final String? description;
  final String? videoUrl;


  MainTestListModel({
    this.id,
    this.courseId,
    this.testTypeId,
    this.name,
    this.hasWindowTimeLimit,
    this.fromDate,
    this.toDate,
    this.cutOffMarks,
    this.status,
    this.description,
    this.videoUrl,

  });

  factory MainTestListModel.fromJson(Map<String, dynamic> json) {
    return MainTestListModel(
      id: json['id'],
      courseId: json['course_id '],
      testTypeId: json['test_type_id'],
      name: json['name'],
      hasWindowTimeLimit: json['has_window_time_limit'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      cutOffMarks: json['cut_off_marks'],
      status: json['status'],
      description: json['description'],
      videoUrl: json['video_url '],

    );
  }
}
