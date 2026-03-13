/*
MODEL
1. menggantikan penggunaan Map<String,dynamic>
2. Sebagai blueprint yang mengubah data mentah dari JSON API menjadi objek Dart
*/
class CommunityModel {

  // Deklarasi variabel
  String communityId;
  String communityName;
  String description;
  String? announcementGroupId;

  // Constructor yang nantinya bakal yg nntinya bakal dipake buat pembuatan objek berdasarkan class ini
  CommunityModel({
    required this.communityId,
    required this.communityName,
    required this.description,
    this.announcementGroupId,
  });

  // dipake buat ngubah data JSON jadi object 
  factory CommunityModel.fromJson(Map<String,dynamic> json){
    return CommunityModel(
      communityId: json['community_id'],
      communityName: json['community_name'],
      description: json['description'],
      announcementGroupId: json['announcement_group_id']
    );
  }
}