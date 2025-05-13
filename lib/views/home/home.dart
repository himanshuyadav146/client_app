import 'package:client_app/core/index.dart';
import 'package:client_app/core/widgets/carousel_widget.dart';
import 'package:client_app/core/widgets/core_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constant/icon_constant.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: _buildHomeView(context),
    );
  }
}

Widget _buildHomeView(BuildContext context) {
  final List<String> imgList = [
    'https://www.moneyseth.com/media/blog_headers/itr_filing_for_salary.webp',
    'https://www.jurishour.in/wp-content/uploads/2025/04/gst-registration-document.webp',
    'https://www.indiafilings.com/learn/wp-content/uploads/2024/04/How-To-Check-And-Authenticate-Income-Tax-Notice-Online.jpg',
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CarouselWidget(
        imgList: imgList,
        onTap: (p0) {},
      ),
      Spacer(),
      Padding(
        padding: AppPadding.paddingAllM,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: CoreLevel(
                  textAlign: TextAlign.center,
                  text: kFileYourTax,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CoreLevel(
                text: kFileYourTaxSubtitle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CoreButton(
                  text: kFileITR,
                  onPressed: () {
                    GoRouter.of(context).push(RouteName.incomeSource);
                  }),
            )
          ],
        ),
      )
    ],
  );
}
