
class PracticeBooksModel{
  final int? id;
  final String? name;
  final String? fileName;
  final String? filePath;
  final String? host;

  PracticeBooksModel({
    this.id,
    this.name,
    this.fileName,
    this.filePath,
    this.host,
  });

  factory PracticeBooksModel.fromJson(Map<String, dynamic>json){
    return PracticeBooksModel(
      id: json["id"],
      name:json["name"],
      fileName:json["file_name"],
      filePath:json["file_path"],
      host:json["host"],
    );
  }
}
