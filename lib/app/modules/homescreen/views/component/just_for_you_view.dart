import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:get/get.dart';
import 'package:shoesexe/app/modules/homescreen/controllers/homescreen_controller.dart';

class JustForYouView extends GetView<HomescreenController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.3,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            height: Get.height * 0.09,
            width: double.infinity,
            child: Text(
              "Just For You",
              style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Container(
              child: CarouselSlider.builder(
                itemCount: controller.poster.length,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 18 / 8,
                  enlargeCenterPage: true,
                ),
                itemBuilder: (context, index, realIndex) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 3,
                  child: Container(
                    height: Get.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("${controller.poster[index]}"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
