import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:io';

class Dialogs {
  
    static Future<dynamic> errorDialog(context,String title, String dec) {
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.TOPSLIDE,
            tittle: title,
            desc: dec,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {})
        .show();
  }

  static Future<dynamic> successDialog(context,String title, String dec) {
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.TOPSLIDE,
            tittle: title,
            desc: dec,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {})
        .show();
  }

  
}