import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_hub/service/app_string_service.dart';
import 'package:clean_hub/service/rtl_service.dart';

import '../../service/common_service.dart';

late double screenWidth;
late double screenHeight;
late AppStringService lnProvider;
late RtlService rtlProvider;
var _chatSellerId;

getScreenSize(BuildContext context) {
  screenWidth = MediaQuery.of(context).size.width;
  screenHeight = MediaQuery.of(context).size.height;
}

initializeLNProvider(BuildContext context) {
  lnProvider = Provider.of<AppStringService>(context, listen: false);
  rtlProvider = Provider.of<RtlService>(context, listen: false);
}

screenSizeAndPlatform(BuildContext context) {
  getScreenSize(context);
  checkPlatform();
}

setChatSellerId(value) {
  _chatSellerId = value;
}

String? get chatSellerId {
  return _chatSellerId?.toString();
}
//responsive screen codes ========>

var fourinchScreenHeight = 610;
var fourinchScreenWidth = 385;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
