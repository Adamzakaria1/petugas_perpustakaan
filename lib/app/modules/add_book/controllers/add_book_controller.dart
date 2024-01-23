import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petugas_pepustakaan_kelas_b11/app/data/constant/endpoint.dart';
import 'package:petugas_pepustakaan_kelas_b11/app/data/provider/api_provider.dart';
import 'package:petugas_pepustakaan_kelas_b11/app/modules/book/controllers/book_controller.dart';

class AddBookController extends GetxController {
  final loading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahunTerbitController = TextEditingController();
  // final BookController bookController = Get.put(BookController()); //mengambil
  final BookController bookController = Get.find(); //mencari

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  post() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();// close keyboard
      formkey.currentState?.save();
      if (formkey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.book,
            data: {
              "judul": judulController.text.toString(),
              "penulis": penulisController.text.toString(),
              "penerbit": penerbitController.text.toString(),
              "tahun_terbit": int.parse(tahunTerbitController.text.toString())
            }
        );
        if (response.statusCode == 201) {
          bookController.getData();
         Get.back();
        } else {
          Get.snackbar("sorry","Gagal menambahkan", backgroundColor: Colors.orange);
        }
      }loading(false);
    } on DioException catch (e) {loading(false);
    if (e.response != null){
      if (e.response?.data != null){
        Get.snackbar("Sorry", "{${e.response?.data['message']}", backgroundColor: Colors.orange);
      }
    } else {
      Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
    }
    } catch (e) {loading(false);
    Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
