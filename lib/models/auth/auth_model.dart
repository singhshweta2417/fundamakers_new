class AuthModel {
   bool?success;
   String?token;
   StudentDetails?studentDetails;

  AuthModel({
     this.success,
     this.token,
     this.studentDetails,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      success: json['success'],
      token: json['token'],
      studentDetails: StudentDetails.fromJson(json['student_details']),
    );
  }
}

class StudentDetails {
   int? studentId;
   String? firstName;
   String? lastName;
   String? mobileNumber;
   int? courseId;
   int? subCourseId;

  StudentDetails({
     this.studentId,
     this.firstName,
    this.lastName,
     this.mobileNumber,
     this.courseId,
     this.subCourseId,
  });

  factory StudentDetails.fromJson(Map<String, dynamic> json) {
    return StudentDetails(
      studentId: json['student_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobileNumber: json['mobile_number'],
      courseId: json['course_id'],
      subCourseId: json['sub_course_id'],
    );
  }
}
