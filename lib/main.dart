import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:public_toilets/screens/home/add_toilet.dart';
import 'package:public_toilets/screens/home/home_page.dart';
import 'package:public_toilets/screens/home/toilet_details.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Public Toilets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: GoogleFonts.kanit().fontFamily,
      ),
      //home: const HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        'add_toilet': (context) => const AddToiletPage(),
        'toilet_details': (context) => const ToiletDetailsPage(),
      },
    );
  }
}
