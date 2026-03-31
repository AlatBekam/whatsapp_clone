/*
MODEL
1. menggantikan penggunaan Map<String,dynamic>
2. Sebagai blueprint yang mengubah data mentah dari JSON API menjadi objek Dart
*/
class CommunityModel {

  // Deklarasi variabel
  String communityId;
  String? communityImageUrl;
  String communityName;
  String description;
  String? announcementGroupId;

  // Constructor yang nantinya bakal yg nntinya bakal dipake buat pembuatan objek berdasarkan class ini
  CommunityModel({
    required this.communityId,
    this.communityImageUrl,
    required this.communityName,
    required this.description,
    this.announcementGroupId,
  });

  // dipake buat ngubah data JSON jadi object 
  factory CommunityModel.fromJson(Map<String,dynamic> json){
    return CommunityModel(
      communityId: json['community_id'],
      communityImageUrl: json['community_image_url'],
      communityName: json['community_name'],
      description: json['description'],
      announcementGroupId: json['announcement_group_id']
    );
  }
}