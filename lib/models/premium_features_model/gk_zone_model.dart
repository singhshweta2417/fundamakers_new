class GkZoneModel{
  final int? id;
  final String? type;
  final String? description;
  final String? uniqueName;
  final String? fileName;
  final String? filePath;
  final String? host;

  GkZoneModel({
    this.id,
    this.type,
    this.description,
    this.uniqueName,
    this.fileName,
    this.filePath,
    this.host
});

  factory GkZoneModel.fromJson(Map<String, dynamic>json){
    return GkZoneModel(
        id: json["id"],
        type:json["type"],
        description:json["description"],
      uniqueName:json["unique_name"],
      fileName:json["file_name"],
      filePath:json["file_path"],
      host:json["host"],
      //"id": 33,
      //             "type": "CurrentAffair",
      //             "description": "May 2020",
      //             "unique_name": "9c7f740fe0938dacbd7687a01d6b75a3.pdf",
      //             "file_name": "May 2020 CA.pdf",
      //             "file_path": "content/",
      //             "host":
    );
  }
}
