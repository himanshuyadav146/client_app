
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/app_sizes.dart';

class UtilToast {
  static void showMessageForUser(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.4),
      textColor: Colors.white,
      fontSize: SizeConfig.defaultSize * 1.6,
    );
  }
}
