import 'dart:convert';
import 'package:get/get.dart';
import '../Services/api_services.dart';
import '../Models/CommunityModel.dart';


// extends GetxController berfungsi untuk menggunakan sistem lifecycle dari GetX
class CommunityController extends GetxController {

  var communities = <CommunityModel>[].obs; //observable (reactive) dari GetX dipake supaya ketika data berubah UI otomatis diupdate
  var isLoading = true.obs;

  @override
  // fungsi yg dijalankan ketika controller pertama kali dibuat
  void onInit() {
    fetchCommunities();
    super.onInit();
  }

  //ambil data komunitas dari server
  Future fetchCommunities() async {
    try {
      isLoading(true);
      var response = await ApiServices().httpGETWithToken(
        "private/community"
      );
      // print("STATUS: ${response.statusCode}");
      // print("BODY: ${response.body}");
      if(response.statusCode == 200){
        List data = jsonDecode(response.body); //mengubah JSON jadi list
        communities.value = data.map((e) => CommunityModel.fromJson(e)).toList(); // mengubah JSON menjadi model
      }
    } finally {
      isLoading(false);
    }
  }

  Future createCommunity(String name, String description) async {
    var response = await ApiServices().httpPOSTWithToken(
      apiUrl: "private/community",
      data: {
        "community_name": name,
        "description": description,
        "announcement_group_id": null
      }
    );

    if(response.statusCode == 200){
      await fetchCommunities();
      return true;
    }
    return false;
  }

  Future updateCommunity(
    String id,
    String name,
    String description
  ) async {
    var response = await ApiServices().httpPUTWithToken(
      apiUrl: "private/community/$id",
      data: {
        "community_name": name,
        "description": description,
      },
    );

    if(response.statusCode == 200){
      await fetchCommunities();
      return true;
    }
    return false;
  }

  Future deleteCommunity(String id) async {
    var response = await ApiServices().httpDELETEWithToken(
      "private/community/$id"
    );
    if(response.statusCode == 200){
      await fetchCommunities();
      return true;
    }
    return false;
  }
}