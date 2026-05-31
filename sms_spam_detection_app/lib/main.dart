import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_spam_detection_app/providers/spam_provider.dart';
import 'package:sms_spam_detection_app/screen/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SpamProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
        home: HomeScreen(),
      ),
    ),
  );
}
