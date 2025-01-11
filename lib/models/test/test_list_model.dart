class TestListModel {
  List<Data>? data;

  TestListModel({this.data});

  TestListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? name;
  String? description;
  int? courseId;
  int? totalSections;
  String? perSectionTime;
  String? positiveMarkingMcq;
  String? negativeMarkingMcq;
  String? positiveMarkingTita;
  String? negativeMarkingTita;
  int? hasTimeLimit;
  int? sectionSwitching;

  Data(
      {this.id,
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
        this.sectionSwitching});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    courseId = json['course_id'];
    totalSections = json['total_sections'];
    perSectionTime = json['per_section_time'];
    positiveMarkingMcq = json['positive_marking_mcq'];
    negativeMarkingMcq = json['negative_marking_mcq'];
    positiveMarkingTita = json['positive_marking_tita'];
    negativeMarkingTita = json['negative_marking_tita'];
    hasTimeLimit = json['has_time_limit'];
    sectionSwitching = json['section_switching'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['course_id'] = courseId;
    data['total_sections'] = totalSections;
    data['per_section_time'] = perSectionTime;
    data['positive_marking_mcq'] = positiveMarkingMcq;
    data['negative_marking_mcq'] = negativeMarkingMcq;
    data['positive_marking_tita'] = positiveMarkingTita;
    data['negative_marking_tita'] = negativeMarkingTita;
    data['has_time_limit'] = hasTimeLimit;
    data['section_switching'] = sectionSwitching;
    return data;
  }
}
