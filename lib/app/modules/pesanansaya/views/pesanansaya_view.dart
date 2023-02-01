import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesexe/app/data/models/data_produk.dart';
import 'package:shoesexe/app/modules/homescreen/bindings/homescreen_binding.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';
import 'package:shoesexe/warna.dart';

import '../controllers/pesanansaya_controller.dart';

class PesanansayaView extends GetView<PesanansayaController> {
  HomescreenController homeC = Get.put(HomescreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Container(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 30,
                color: keempat,
              ),
            ),
          ),
          title: Text(
            'Pesanan Saya',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 18, color: keempat),
          ),
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/images/background7.png",
                fit: BoxFit.cover,
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.pesanan(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  List pesanan = snapshot.data!.docs;
                  if (pesanan.length == 0) {
                    return Container(
                      height: 250,
                      width: 180,
                      child: Column(
                        children: [
                          Container(
                              child: Lottie.asset("assets/lotties/cart.json")),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "Belum Ada Produk",
                              style: GoogleFonts.poppins(),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: pesanan.length,
                      itemBuilder: (context, index) => FutureBuilder(
                            future: controller
                                .detailproduk(pesanan[index]["id_produk"]),
                            builder: (context, snapshotdetail) {
                              if (snapshotdetail.connectionState ==
                                  ConnectionState.done) {
                                ProdukData detailP = ProdukData.fromJson(
                                    snapshotdetail.data!.data()!);
                                return Container(
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  width: Get.width * 0.3,
                                  height: 240,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(70, 128, 128, 128),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: double.infinity,
                                        child: Text(
                                          "${pesanan[index]["nama_toko"]}",
                                          style: GoogleFonts.poppins(
                                              color: ketiga,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Expanded(
                                          child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: kesatu,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Image.network(
                                                    "${detailP.photoUrl}"),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15),
                                                width: 160,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      child: Text(
                                                        "${detailP.namaProduk} asdsadasdad",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        height: 30,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "${homeC.rupiah.format(pesanan[index]["jumlah"] * pesanan[index]["harga"])}",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: ketiga,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            Container(
                                                                child: Text(
                                                                    "${pesanan[index]["jumlah"]} pcs",
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12,
                                                                    ))),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        height: 40,
                                        width: double.infinity,
                                        child: Container(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text("Terima pesanan",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: ketiga,
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return SizedBox(
                                height: 1,
                              );
                            },
                          ));
                }
                return SizedBox(
                  height: 1,
                );
              },
            )
          ],
        ));
  }
}
