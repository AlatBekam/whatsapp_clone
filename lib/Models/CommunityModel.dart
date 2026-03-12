/*
MODEL
1. menggantikan penggunaan Map<String,dynamic>
2. Sebagai blueprint yang mengubah data mentah (misalnya dari JSON API) menjadi objek Dart
*/
class CommunityModel {

  String communityId;
  String communityName;
  String description;
  String? announcementGroupId;

  CommunityModel({
    required this.communityId,
    required this.communityName,
    required this.description,
    this.announcementGroupId,
  });

  factory CommunityModel.fromJson(Map<String,dynamic> json){
    return CommunityModel(
      communityId: json['community_id'] ?? "",
      communityName: json['community_name'] ?? "",
      description: json['description'] ?? "",
      announcementGroupId: json['announcement_group_id']
    );
  }
}