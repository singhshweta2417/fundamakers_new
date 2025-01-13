class PracticeBooksModel {
  List<Data>? data;

  PracticeBooksModel({this.data});

  PracticeBooksModel.fromJson(Map<String, dynamic> json) {
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
  String? fileName;
  String? filePath;
  dynamic host;
  String? subject;

  Data(
      {this.id,
      this.name,
      this.fileName,
      this.filePath,
      this.host,
      this.subject});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    host = json['host'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['file_name'] = fileName;
    data['file_path'] = filePath;
    data['host'] = host;
    data['subject'] = subject;
    return data;
  }
}
