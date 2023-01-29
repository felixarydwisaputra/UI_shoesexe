import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/data_produk.dart';

class CheckoutController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isloading = false.obs;
  RxBool enableBank = false.obs;
  RxString kurir = "".obs;
  ProdukData dataP = Get.arguments[0];
  var dataToko = Get.arguments[1];
  var jumlahProduk = Get.arguments[3];
  var sizeProduk = Get.arguments[2];
  late Map<String, dynamic> dataU;

  // CHECKOUT
  RxInt totalongkir = 0.obs;
  RxInt biayapenanganan = 0.obs;
  RxInt total = 0.obs;
  RxString etd = "".obs;

  Stream<DocumentSnapshot<Map<String, dynamic>>> dataUser(String email) async* {
    yield* firestore.collection("users").doc(email).snapshots();
  }

  // UBAH ALAMAT
  TextEditingController phoneC = TextEditingController();
  TextEditingController alamatC = TextEditingController();

  // TOTAL ONGKIR
  void totalOngkir(
    String asalKota,
    String kotatujuan,
    String berat,
    String kurir,
  ) async {
    try {
      final response = await http
          .post(Uri.parse("https://api.rajaongkir.com/starter/cost"), headers: {
        "key": "7e29ffa20c825c9d734d5b79ced0316b"
      }, body: {
        "origin": asalKota,
        "destination": kotatujuan,
        "weight": berat,
        "courier": kurir,
      });

      var data = json.decode(response.body) as Map<String, dynamic>;
      var hasil = data["rajaongkir"]["results"];
      totalongkir.value = hasil[0]["costs"][0]["cost"][0]["value"];
      etd.value = hasil[0]["costs"][0]["cost"][0]["etd"];
      total.value = dataP.harga! + totalongkir.value + biayapenanganan.value;
    } catch (e) {
      Get.snackbar("Terjadi keslahan", e.toString());
    }
  }

  // TOTAL CHECKOUT
  void totalCheckout() {
    total.value = dataP.harga! + totalongkir.value + biayapenanganan.value;
  }
}