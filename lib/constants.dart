import 'package:flutter/material.dart';

const backColor = Color(0xFFF8F8F8);
const secondaryColor = Color(0xFFF05A76);
const cardPrimaryColor = Color(0xFFFFFFFF);
const cardSecondaryColor = Color(0xFFEEEEEE);

const textPrimaryColor = Colors.black;
const textSecondaryColor = Colors.black38;

Container getBoxButton(String img) => Container(
      height: 38,
      width: 38,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: cardPrimaryColor,
      ),
      child: Image.asset(img, fit: BoxFit.contain),
    );
