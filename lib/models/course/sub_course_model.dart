class SubCourseModel {
  List<SubCourseData>? data;

  SubCourseModel({this.data});

  SubCourseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubCourseData>[];
      json['data'].forEach((v) {
        data!.add(SubCourseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCourseData {
  int? id;
  int? courseId;
  String? name;

  SubCourseData({this.id, this.courseId, this.name});

  SubCourseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['name'] = name;
    return data;
  }
}
