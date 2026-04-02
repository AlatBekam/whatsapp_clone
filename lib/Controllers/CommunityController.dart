import 'package:get/get.dart';
import '../Services/api_services.dart';
import '../Models/CommunityModel.dart';
import 'package:flutter/material.dart';
import '../Services/route_handler.dart';
import '../widgets/enum_status.dart';
import 'dart:io';
import '../Services/gambar_service.dart';

CommunityController communityController = Get.find<CommunityController>();

class CommunityController extends GetxController {
  ApiServices apiServices = ApiServices();

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
     String? imageUrl = await uploadCommunityImage();
     await apiServices.httpPOSTWithToken(
        apiUrl: "private/community",
        data: {
          "community_image_url": imageUrl,
          "community_name": name,
          "description": description,
          "announcement_group_id": null,
        },
      );

      await fetchCommunities();
      gambarService.clearImage();
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
      String? imageUrl = selectedCommunity.value?.communityImageUrl;

      if (gambarService.selectedImage.value != null) {
        imageUrl = await uploadCommunityImage();
      }

      await apiServices.httpPUTWithToken(
        apiUrl: "private/community/$id",
        data: {
          "community_image_url": imageUrl,
          "community_name": name,
          "description": description,
        },
      );

      await fetchCommunities();
      gambarService.clearImage();
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

  // UPLOAD IMAGE
  Future<String?> uploadCommunityImage() async {
    final image = gambarService.selectedImage.value;
    if (image == null) return null;

    return await apiServices.uploadImageWithToken(
      file: File(image.path),
      apiUrl: "private/upload",
      folder: "community",
    );
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