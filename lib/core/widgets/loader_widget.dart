import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

class LoaderWidget extends StatefulWidget {
  final double size;

  const LoaderWidget({super.key, this.size = 60});

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              color: kLightSecondaryColor,
            )
          : CupertinoActivityIndicator(
              color: kLightSecondaryColor,
            ),
    );
  }
}
