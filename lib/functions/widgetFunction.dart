import 'package:flutter/material.dart';

SizedBox buildSizedBoxHeight(int value) {
  return SizedBox(
    height: value.toDouble(),
  );
}

double buildWidth(BuildContext context) => MediaQuery.of(context).size.width;

double buildHeight(BuildContext context) => MediaQuery.of(context).size.height;
