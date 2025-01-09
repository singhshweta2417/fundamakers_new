
class GkDetailsModel{
  final int? id;
  final String? type;
  final String? description;
  final String? uniqueName;
  final String? fileName;
  final String? filePath;
  final String? host;

  GkDetailsModel({
    this.id,
    this.type,
    this.description,
    this.uniqueName,
    this.fileName,
    this.filePath,
    this.host,
  });

  factory GkDetailsModel.fromJson(Map<String, dynamic>json){
    return GkDetailsModel(
      id: json["id"],
      type:json["type"],
      description:json["description"],
      uniqueName:json["unique_name"],
      fileName:json["file_name"],
      filePath:json["file_path"],
      host:json["host"],
    );
  }
}
