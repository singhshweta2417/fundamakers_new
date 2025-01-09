
class VideoLectureDetailsModel {
  int? id;
  int? subjectId;
  int? topicId;
  String? videoTitle;
  String? description;
  int? priority;
  String? thumbnailUrl;

  VideoLectureDetailsModel({
    this.id,
    this.subjectId,
    this.topicId,
    this.videoTitle,
    this.description,
    this.priority,
    this.thumbnailUrl,
  });

  factory VideoLectureDetailsModel.fromJson(Map<String, dynamic> json) {
    return VideoLectureDetailsModel(
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
