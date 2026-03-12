import 'dart:convert';
import 'package:get/get.dart';
import '../Services/api_services.dart';
import '../Models/CommunityModel.dart';

class CommunityController extends GetxController {

  // STATE
  var communities = <CommunityModel>[].obs;
  var isLoading = false.obs;

  // FETCH COMMUNITY
  Future<void> fetchCommunities() async {
    try {
      isLoading.value = true;
      var response =
          await ApiServices().httpGETWithToken(
              "private/community"
          );
      print("STATUS CODE : ${response.statusCode}");
      print("BODY : ${response.body}");
      print("TYPE BODY : ${response.body.runtimeType}");
      if(response.statusCode == 200){
        List data = jsonDecode(response.body);
        communities.value =
            data
            .map((e) => CommunityModel.fromJson(e))
            .toList();
      } else {
        print("FETCH COMMUNITY FAILED : ${response.statusCode}");
      }
    } catch(e){
      print("ERROR COMMUNITY : $e");
    } finally {
      isLoading.value = false;
    }
  }

  // CREATE COMMUNITY
  Future<bool> createCommunity(
      String nama,
      String deskripsi
      ) async {
    try {
      var response =
          await ApiServices().httpPOSTWithToken(
        apiUrl: "private/community",
        data: {
          "community_name": nama,
          "description": deskripsi,
          "announcement_group_id": null
        }
      );
      if(response.statusCode == 200){
        await fetchCommunities();
        return true;
      }
    } catch(e){
      print("CREATE COMMUNITY ERROR : $e");
    }
    return false;
  }

  // UPDATE COMMUNITY
  Future<bool> updateCommunity(
      int id,
      String nama,
      String deskripsi
      ) async {
    try {
      var response =
          await ApiServices().httpPUTWithToken(
        apiUrl: "private/community/$id",
        data: {
          "community_name": nama,
          "description": deskripsi
        }
      );
      if(response.statusCode == 200){
        await fetchCommunities();
        return true;
      }
    } catch(e){
      print("UPDATE COMMUNITY ERROR : $e");
    }
    return false;
  }

  // DELETE COMMUNITY
  Future<void> deleteCommunity(int id) async {
    try {
      await ApiServices()
          .httpDELETEWithToken(
          "private/community/$id"
      );
      await fetchCommunities();
    } catch(e){
      print("DELETE COMMUNITY ERROR : $e");
    }
  }

  // INIT
  @override
  void onInit() {
    fetchCommunities();
    super.onInit();
  }
}