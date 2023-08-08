import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/empty.png',
            height: 180,
            width: 180,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Data Kosong",
            style: GoogleFonts.tajawal(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xffffca54)),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              "Data dari server masih belum ada nih ...",
              style: GoogleFonts.cairo(
                color: Color(0xff777777),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
