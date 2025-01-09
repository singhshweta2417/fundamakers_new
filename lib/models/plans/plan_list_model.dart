class PlanListModel {
  final int? id;
  final int? subCourseId;
  final String? name;
  final String? intro;
  final String? shortDescription;
  final String? description;
  final String? amount;

  PlanListModel({
    this.id,
    this.subCourseId,
    this.name,
    this.intro,
    this.shortDescription,
    this.description,
    this.amount,
  });

  factory PlanListModel.fromJson(Map<String, dynamic> json) {
    return PlanListModel(
      id: json['id'],
      subCourseId: json['sub_course_id'],
      name: json['name'],
      intro: json['intro'],
      shortDescription: json['short_description'],
      description: json['description'],
      amount: json['amount'],
    );
  }
}
