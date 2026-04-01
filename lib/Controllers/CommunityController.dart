import 'package:get/get.dart';
import '../Services/api_services.dart';
import '../Services/http_handler.dart';
import '../Models/CommunityModel.dart';
import 'package:flutter/material.dart';
import '../Services/route_handler.dart';
import '../widgets/enum_status.dart';

CommunityController communityController = Get.find<CommunityController>();

class CommunityController extends GetxController {
  ApiServices apiServices = ApiServices();
  AuthService _authService = AuthService();

  // tambahkan bagian untuk menerima data gambar profil komunitas
  final TextEditingController nama = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();

  Rxn<CommunityModel> selectedCommunity = Rxn<CommunityModel>();
  CommunityModel get community => selectedCommunity.value!;

  var communities = <CommunityModel>[].obs;
  var status = Status.loading.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchCommunities();
    super.onInit();
  }

  // GET COMMUNITIES (SUDAH CLEAN)
  Future fetchCommunities() async {
    status.value = Status.loading;
    try {
      final data = await apiServices.httpGETWithToken("private/community");

      communities.value = (data as List)
          .map((e) => CommunityModel.fromJson(e))
          .toList();
      if (communities.isEmpty) {
        status.value = Status.empty;
      } else {
        status.value = Status.success;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      status.value = Status.error;
    }
  }

  // CREATE
  Future createCommunity(String name, String description) async {
    status.value = Status.loading;
    try {
     await apiServices.httpPOSTWithToken(
        apiUrl: "private/community",
        data: {
          "community_image_url": null,
          "community_name": name,
          "description": description,
          "announcement_group_id": null,
        },
      );

      await fetchCommunities();
      return true;
    } catch (e) {
      status.value = Status.error;
      return e.toString();
    }
  }

  // UPDATE
  Future updateCommunity(String id, String name, String description) async {
    status.value = Status.loading;
    try {
      await apiServices.httpPUTWithToken(
        apiUrl: "private/community/$id",
        data: {
          "community_image_url": null,
          "community_name": name,
          "description": description,
        },
      );

      await fetchCommunities();
      return true;
    } catch (e) {
      status.value = Status.error;
      return e.toString();
    }
  }

  // DELETE
  Future deleteCommunity(String id) async {
    status.value = Status.loading; 
    try {
      await apiServices.httpDELETEWithToken(
        "private/community/$id",
      );

      communities.removeWhere((item) => item.communityId == id);

      status.value = communities.isEmpty
        ? Status.empty
        : Status.success;
      return true;
    } catch (e) {
      status.value = Status.error; 
      return e.toString();
    }
  }

  // NAVIGATION
  Future<dynamic>? goDetail(dynamic community) {
    selectedCommunity.value = community;
    return Get.toNamed(Routes.communityInfo);
  }

  void clearForm() {
    nama.clear();
    deskripsi.clear();
  }
}


// import 'dart:convert';
// import 'package:get/get.dart';
// import '../Services/api_services.dart';
// import '../Models/CommunityModel.dart';
// import 'package:flutter/material.dart';
// import '../Services/route_handler.dart';

// CommunityController communityController = Get.find<CommunityController>();

// // extends GetxController berfungsi untuk menggunakan sistem lifecycle dari GetX
// class CommunityController extends GetxController {
//   final TextEditingController nama = TextEditingController();
//   final TextEditingController deskripsi = TextEditingController();
//   Rxn<CommunityModel> selectedCommunity = Rxn<CommunityModel>();
//   CommunityModel get community => selectedCommunity.value!;

//   var communities = <CommunityModel>[].obs; //observable (reactive) dari GetX dipake supaya ketika data berubah UI otomatis diupdate
//   var isLoading = true.obs;

//   @override
//   // fungsi yg dijalankan ketika controller pertama kali dibuat
//   void onInit() {
//     fetchCommunities();
//     super.onInit();
//   }

//   //ambil data komunitas dari server
//   Future fetchCommunities() async {
//     try {
//       isLoading(true);
//       var response = await ApiServices().httpGETWithToken(
//         "private/community"
//       );
//       // print("STATUS: ${response.statusCode}");
//       // print("BODY: ${response.body}");
//       if(response.statusCode == 200){
//         List data = jsonDecode(response.body); //mengubah JSON jadi list
//         communities.value = data.map((e) => CommunityModel.fromJson(e)).toList(); // mengubah JSON menjadi model
//       }
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future createCommunity(String name, String description) async {
//     var response = await ApiServices().httpPOSTWithToken(
//       apiUrl: "private/community",
//       data: {
//         "community_name": name,
//         "description": description,
//         "announcement_group_id": null
//       }
//     );

//     if(response.statusCode == 200){
//       await fetchCommunities();
//       return true;
//     }
//     return false;
//   }

//   Future updateCommunity(
//     String id,
//     String name,
//     String description
//   ) async {
//     var response = await ApiServices().httpPUTWithToken(
//       apiUrl: "private/community/$id",
//       data: {
//         "community_name": name,
//         "description": description,
//       },
//     );

//     if(response.statusCode == 200){
//       await fetchCommunities();
//       return true;
//     }
//     return false;
//   }

//   Future deleteCommunity(String id) async {
//     var response = await ApiServices().httpDELETEWithToken(
//       "private/community/$id"
//     );
//     if(response.statusCode == 200){
//       await fetchCommunities();
//       return true;
//     }
//     return false;
//   }

//   // Future<dynamic>? goDetail(dynamic community) {
//   //   return Get.toNamed(Routes.communityInfo, arguments: community);
//   // }

//   Future<dynamic>? goDetail(dynamic community) {
//     selectedCommunity.value = community;
//     return Get.toNamed(Routes.communityInfo);
//   }
  
//   void clearForm(){
//   nama.clear();
//   deskripsi.clear();
// }
// }
