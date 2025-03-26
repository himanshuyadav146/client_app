import 'package:client_app/core/index.dart';
import 'package:client_app/core/widgets/core_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constant/icon_constant.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      title: 'Choose Services',
      body: _buildHomeView(),
      isDrawer: false,
      isResizeToAvoidBottomInset: false,
      appBarBackgroundColor: Theme.of(context).primaryColor,
      appBarForegroundColor: Colors.white,
    );
  }
}

Widget _buildHomeView() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              ICON_CONST.banner,
              height: 150,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
      Padding(
        padding: AppPadding.paddingAllM,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: CoreLevel(
                  textAlign: TextAlign.center,
                  text: kFileYourTax,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            CoreLevel(text: 'Simple Tax * Maximum Saving * Accuracy'),
            SizedBox(
              height: 20,
            ),
            CoreButton(text: 'Start your tax return', onPressed: () {

            })
          ],
        ),
      )
    ],
  );
}
