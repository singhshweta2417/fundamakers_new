class VideoLectureModel {
   int? id;
   int? subjectId;
   int? topicId;
   String? videoTitle;
   String? description;
   int? priority;
   String? thumbnailUrl;

  VideoLectureModel({
     this.id,
     this.subjectId,
     this.topicId,
     this.videoTitle,
     this.description,
     this.priority,
     this.thumbnailUrl,
  });



  factory VideoLectureModel.fromJson(Map<String, dynamic> json) {
    return VideoLectureModel(
      id: json['id'],
      subjectId: json['subject_id'],
      topicId: json['topic_id'],
      videoTitle: json['video_title'],
      description: json['description'],
      priority: json['priority'],
      thumbnailUrl: json['thumbnail_url'],
    );
  }
}
