class TopicModel {
  final dynamic id;
  final dynamic subjectId;
  final dynamic name;

  TopicModel({
    this.id,
    this.subjectId,
    this.name,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json["id"],
      subjectId: json["subject_id"],
      name: json[ "name"],
    );
  }
}

