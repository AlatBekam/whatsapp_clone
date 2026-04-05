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

  final TextEditingController nama = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  final ScrollController scrollController = ScrollController();

  Rxn<CommunityModel> selectedCommunity = Rxn<CommunityModel>();
  CommunityModel get community => selectedCommunity.value!;

  var communities = <CommunityModel>[].obs;
  var status = Status.loading.obs;
  var errorMessage = ''.obs;

  // PAGINATION STATE
  var currentPage = 1.obs;
  var hasMore = true.obs;
  var isFetchingMore = false.obs;
  final int limit = 3;

  @override
  void onInit() {
    super.onInit();
    fetchCommunities();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        fetchCommunities(isLoadMore: true);
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    nama.dispose();
    deskripsi.dispose();
    super.onClose();
  }

  // GET COMMUNITIES
  Future fetchCommunities({bool isLoadMore = false}) async {
    if (isFetchingMore.value || !hasMore.value && isLoadMore) return;

    if (!isLoadMore) {
      status.value = Status.loading;
      currentPage.value = 1;
      hasMore.value = true;
      communities.clear();
    }

    isFetchingMore.value = true;

    try {
      final data = await apiServices.httpGETWithToken(
        "private/community?page=${currentPage.value}&limit=$limit",
      );

      final List<CommunityModel> newCommunities = (data["data"] as List)
          .map((e) => CommunityModel.fromJson(e))
          .toList();

      if (newCommunities.length < limit) {
        hasMore.value = false;
      } else {
        currentPage.value++;
      }
      communities.addAll(newCommunities);

      status.value = communities.isEmpty ? Status.empty : Status.success;
    } catch (e) {
      errorMessage.value = e.toString();
      status.value = Status.error;
    } finally {
      isFetchingMore.value = false;
    }

    // status.value = Status.loading;
    // try {
    //   final data = await apiServices.httpGETWithToken("private/community");

    //   communities.value = (data as List)
    //       .map((e) => CommunityModel.fromJson(e))
    //       .toList();
    //   if (communities.isEmpty) {
    //     status.value = Status.empty;
    //   } else {
    //     status.value = Status.success;
    //   }
    // } catch (e) {
    //   errorMessage.value = e.toString();
    //   status.value = Status.error;
    // }
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
      await apiServices.httpDELETEWithToken("private/community/$id");

      communities.removeWhere((item) => item.communityId == id);

      status.value = communities.isEmpty ? Status.empty : Status.success;
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

    return await apiServices.httpPOSTWithFile(
      file: File(image.path),
      apiUrl: "private/upload",
      paths: "community",
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

  Future initData() async {
    await fetchCommunities();
  }
}
