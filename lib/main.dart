import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'core/providers/bill_data_provider.dart';
import 'pages/bill.dart';

void main() {
  runApp(const Billy());
}

class Billy extends StatelessWidget {
  const Billy({super.key});

  @override
  Widget build(BuildContext context) {
    final billString = Uri.base.queryParameters['bill'];
    return ChangeNotifierProvider(
      create: (context) => BillDataProvider(),
      child: MaterialApp(
        title: 'billy',
        theme: ThemeData(
            useMaterial3: true,
            platform: TargetPlatform.android,
            textTheme: GoogleFonts.srirachaTextTheme(),
            primaryColor: const Color(0xffe1e7ea),
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: const Color(0xff2f4550),
                onPrimary: const Color(0xfff4f4f9),
                inversePrimary: const Color(0xfff4f4f9),
                secondary: const Color(0xff586f7c),
                onSecondary: const Color(0xffb8dbd9),
                error: Colors.red,
                onError: Colors.white,
                background: const Color(0xfff4f4f9),
                onBackground: const Color(0xff2f4550),
                surface: HSLColor.fromColor(const Color(0xff586f7c))
                    .withLightness(0.9)
                    .toColor(),
                onSurface: const Color(0xff2f4550),
                inverseSurface: const Color(0xff2f4550),
                onInverseSurface: const Color(0xfff4f4f9)),
            tabBarTheme: TabBarTheme(
                labelColor: const Color(0xff2f4550),
                unselectedLabelColor: const Color(0xff586f7c),
                indicator: MaterialIndicator(
                    color: const Color(0xff2f4550),
                    height: 4,
                    topLeftRadius: 8,
                    topRightRadius: 8)),
            scaffoldBackgroundColor: const Color(0xfff4f4f9),
            chipTheme: ChipThemeData(
                backgroundColor: const Color(0xffc8d0d6),
                checkmarkColor: const Color(0xff2f4550),
                iconTheme: const IconThemeData(color: Color(0xff2f4550)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                side: const BorderSide(color: Colors.transparent)),
            inputDecorationTheme:
                const InputDecorationTheme(filled: true, errorMaxLines: 1),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xff586f7c),
            )),
        home: BillPage(billString: billString),
      ),
    );
  }
}
