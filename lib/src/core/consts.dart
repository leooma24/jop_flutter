import 'package:flutter/material.dart';

class AppColors { 

  static final primary = Color(0XFF0D1240);
  static final secondary = Color(0XFFD6DFF3);
  static final terceary = Color(0XFF5D4E9B);
  static final Color accent = Color(0XFFff6f00);
}

class AppFontStyles {
  static final TextStyle titulo = TextStyle( fontWeight: FontWeight.bold, fontSize: 16.0);
  static final TextStyle subtitulo = TextStyle( fontWeight: FontWeight.w400, fontSize: 12.0, color: Colors.grey );
}

class Api {
  static String url = '192.168.1.68:8000';  
  static int distance = 10000;  
}