
class TestListModel {
  final int? id;
  final String? name;
  final String? description;
  final int? courseId;
  final int? totalSections;
  final String? perSectionTime;
  final String? positiveMarkingMcq;
  final String? negativeMarkingMcq;
  final String? positiveMarkingTita;
  final String? negativeMarkingTita;
  final int? hasTimeLimit;
  final int? sectionSwitching;

  TestListModel({
    this.id,
    this.name,
    this.description,
    this.courseId,
    this.totalSections,
    this.perSectionTime,
    this.positiveMarkingMcq,
    this.negativeMarkingMcq,
    this.positiveMarkingTita,
    this.negativeMarkingTita,
    this.hasTimeLimit,
    this.sectionSwitching,
  });

  factory TestListModel.fromJson(Map<String, dynamic> json) {
    return TestListModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      courseId: json['course_id'],
      totalSections: json['total_sections'],
      perSectionTime: json['per_section_time'],
      positiveMarkingMcq: json['positive_marking_mcq'],
      negativeMarkingMcq: json['negative_marking_mcq'],
      positiveMarkingTita: json['positive_marking_tita'],
      negativeMarkingTita: json['negative_marking_tita'],
      hasTimeLimit: json['has_time_limit'],
      sectionSwitching: json['section_switching'],
    );
  }
}
