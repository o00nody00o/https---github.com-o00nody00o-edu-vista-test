// ignore_for_file: prefer_const_constructors, camel_case_types, must_be_immutable, unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoriesFilter extends StatelessWidget {
  double? containerwidth;
  double? containerheight;

  double? fontSize;
  FontWeight? fontWeight;
  String? text;
  CategoriesFilter({
    super.key,
    required this.text,
    required this.containerwidth,
    required this.containerheight,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerwidth,
      height: containerheight,
      decoration: BoxDecoration(
        color: Color(0x92ADB2B2),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Text('$text',
            style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: 0,
            )),
      ),
    );
  }
}

class mycourse extends StatelessWidget {
  String? bigImage;
  String? courseAuther;
  String? price;
  String? courseName;

  mycourse({
    super.key,
    required this.bigImage,
    required this.courseAuther,
    required this.price,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 161,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    '$bigImage',
                    // width: 300,
                    // height: 100,
                    width: 151,

                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/rate.png',
                  //  width: 161,
                  //     height: 25,
                  width: 151,

                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 4),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$courseName',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF0E0E0F),
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          )),
                      Container(
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.person_outlined,
                              color: Colors.black,
                              size: 15,
                            ),
                            Text('$courseAuther',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF131415),
                                  letterSpacing: 0,
                                )),
                          ],
                        ),
                      ),
                      Text('\$$price',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF488898),
                            fontSize: 15,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          )),
                    ]),
              ),
            ]),
      ),
    );
  }
}
