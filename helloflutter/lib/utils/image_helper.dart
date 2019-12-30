import 'package:flutter/material.dart';

///图片加载工具类，用于产生Image
class ImageHelper {
  static String png(String name) {
    return "assets/images/$name.png";
  }

  static Widget icon(String name, {double width, double height, BoxFit boxFit}) {
    return Image.asset(
      png(name),
      width: width,
      height: height,
      fit: boxFit,
    );
  }
}