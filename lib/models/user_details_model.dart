class UserDetailsModel {
  Data? data;

  UserDetailsModel({this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? studentId;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  int? courseId;
  int? subCourseId;

  Data(
      {this.studentId,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.courseId,
        this.subCourseId});

  Data.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    courseId = json['course_id'];
    subCourseId = json['sub_course_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile_number'] = mobileNumber;
    data['course_id'] = courseId;
    data['sub_course_id'] = subCourseId;
    return data;
  }
}


////
class ErrorModel {
  Error? error;

  ErrorModel({this.error});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (error != null) {
      data['error'] = error!.toJson();
    }
    return data;
  }
}

class Error {
  List<String>? firstName;
  List<String>? lastName;

  Error({this.firstName, this.lastName});

  Error.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'].cast<String>();
    lastName = json['last_name'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
