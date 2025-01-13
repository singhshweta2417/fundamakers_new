class GkModel {
  List<Data>? data;

  GkModel({this.data});

  GkModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? description;
  String? uniqueName;
  String? fileName;
  String? filePath;
  dynamic host;

  Data(
      {this.id,
        this.type,
        this.description,
        this.uniqueName,
        this.fileName,
        this.filePath,
        this.host});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    description = json['description'];
    uniqueName = json['unique_name'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    host = json['host'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['description'] = description;
    data['unique_name'] = uniqueName;
    data['file_name'] = fileName;
    data['file_path'] = filePath;
    data['host'] = host;
    return data;
  }
}
