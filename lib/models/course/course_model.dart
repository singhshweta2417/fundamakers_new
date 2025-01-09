class CourseModel {
  final int? id;
  final String? name;
  final String? description;

  CourseModel({
     this.id,
     this.name,
     this.description,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

