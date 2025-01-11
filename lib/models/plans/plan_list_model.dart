class PlansListModel {
  List<Data>? data;

  PlansListModel({this.data});

  PlansListModel.fromJson(Map<String, dynamic> json) {
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
  int? subCourseId;
  String? name;
  String? intro;
  String? shortDescription;
  String? description;
  String? amount;

  Data(
      {this.id,
        this.subCourseId,
        this.name,
        this.intro,
        this.shortDescription,
        this.description,
        this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCourseId = json['sub_course_id'];
    name = json['name'];
    intro = json['intro'];
    shortDescription = json['short_description'];
    description = json['description'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_course_id'] = subCourseId;
    data['name'] = name;
    data['intro'] = intro;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['amount'] = amount;
    return data;
  }
}
