import 'dart:convert';
import 'package:get/get.dart';
import '../Services/api_services.dart';
import '../Models/CommunityModel.dart';

class CommunityController extends GetxController {

  var communities = <CommunityModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCommunities();
    super.onInit();
  }

  Future fetchCommunities() async {
    try {
      isLoading(true);
      var response = await ApiServices().httpGETWithToken(
        "private/community"
      );
      // print("STATUS: ${response.statusCode}");
      // print("BODY: ${response.body}");
      if(response.statusCode == 200){
        List data = jsonDecode(response.body);
        communities.value = data.map((e) => CommunityModel.fromJson(e)).toList();
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