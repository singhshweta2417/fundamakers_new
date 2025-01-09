class SubCourseModel {
  int? id;
  dynamic courseId;
  dynamic name;

  SubCourseModel({
    this.id,
    this.courseId,
    this.name,
  });

  factory SubCourseModel.fromJson(Map<String, dynamic> json) {
    return SubCourseModel(
      id: json["id"],
      courseId: json["course_id"],
      name: json[ "name"],
    );
  }
}

