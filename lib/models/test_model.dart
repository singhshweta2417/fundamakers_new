class TestModel {
  List<Data>? data;
  Links? links;
  Meta? meta;

  TestModel({this.data, this.links, this.meta});

  TestModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? courseId;
  int? testTypeId;
  String? name;
  int? hasWindowTimeLimit;
  String? fromDate;
  String? toDate;
  int? cutOffMarks;
  int? status;
  String? description;
  String? videoUrl;

  Data(
      {this.id,
        this.courseId,
        this.testTypeId,
        this.name,
        this.hasWindowTimeLimit,
        this.fromDate,
        this.toDate,
        this.cutOffMarks,
        this.status,
        this.description,
        this.videoUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    testTypeId = json['test_type_id'];
    name = json['name'];
    hasWindowTimeLimit = json['has_window_time_limit'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    cutOffMarks = json['cut_off_marks'];
    status = json['status'];
    description = json['description'];
    videoUrl = json['video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['test_type_id'] = testTypeId;
    data['name'] = name;
    data['has_window_time_limit'] = hasWindowTimeLimit;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['cut_off_marks'] = cutOffMarks;
    data['status'] = status;
    data['description'] = description;
    data['video_url'] = videoUrl;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev;
    data['next'] = next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<MetaLinks>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({this.currentPage, this.from, this.lastPage, this.links, this.path, this.perPage, this.to, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <MetaLinks>[];
      json['links'].forEach((v) {
        links!.add(MetaLinks.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class MetaLinks {
  String? url;
  String? label;
  bool? active;

  MetaLinks({this.url, this.label, this.active});

  MetaLinks.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

