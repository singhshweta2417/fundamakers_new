class SubjectModel {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final String? video;

  SubjectModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.video,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      video: json['video'],
    );
  }
}
