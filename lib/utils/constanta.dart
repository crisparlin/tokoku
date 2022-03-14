import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

TextStyle poppinsTextFont = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w400);
TextStyle nunitoTextFont = GoogleFonts.nunitoSans()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w400);

final currencyFormatter = NumberFormat("#,##0", "id_ID");

dialogsPopup(String urlLottie, String text) => AlertDialog(
    backgroundColor: Colors.white,
    content: Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(urlLottie, height: 150),
          ),
          SizedBox(height: 10),
          Text(text,
              style: nunitoTextFont.copyWith(
                  fontWeight: FontWeight.w700, color: Colors.black)),
        ],
      ),
    ));
