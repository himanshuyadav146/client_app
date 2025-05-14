import 'package:client_app/core/widgets/core_text.dart';
import 'package:client_app/core/widgets/rounded_image_text_card.dart';
import 'package:client_app/views/documents_upload/upload_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constant/app_sizes.dart';
import '../../core/constant/colors.dart';
import '../../core/constant/icon_constant.dart';
import '../../core/route/route_name.dart';
import '../../core/widgets/core_button.dart';
import '../../core/widgets/core_scafold.dart';

class DocumentsUpload extends StatefulWidget {
  const DocumentsUpload({super.key});

  @override
  State<DocumentsUpload> createState() => _DocumentsUploadState();
}

class _DocumentsUploadState extends State<DocumentsUpload> {
  final _formKey = GlobalKey<FormState>();
  bool _formSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
        title: "Documents Upload",
        appBarBackgroundColor: Theme.of(context).primaryColor,
        appBarForegroundColor: Colors.white,
        showBackButton: true,
        body: Padding(
          padding: AppPadding.paddingAllM,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _documentsUpload()),
              const SizedBox(height: AppSizes.paddingS),
              _buildFormSubmit(context),
            ],
          ),
        ),
        backgroundColor: kDocumentBackgroundColor,
        isDrawer: false,
        isResizeToAvoidBottomInset: false);
  }

  Widget _documentsUpload() {
    return Form(
      key: _formKey,
      autovalidateMode: _formSubmitted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UploadProgressBar(),
              const SizedBox(height: AppSizes.paddingXL),
              RoundedImageTextCard(
                imagePath: ICON_CONST.upload,
                isSvg: true,
                title: 'Upload Form - 16 (Part-A)',
                imageRadius: 12.0,
                imageSize: 60.0,
                titleStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                backgroundColor: Colors.grey[100],
                onTap: () => print('Card tapped!'),
              ),
              const SizedBox(height: AppSizes.paddingXL),
              RoundedImageTextCard(
                imagePath: ICON_CONST.upload,
                isSvg: true,
                title: 'Upload Form - 16 (Part-B)',
                imageRadius: 12.0,
                imageSize: 60.0,
                titleStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                backgroundColor: Colors.grey[100],
                onTap: () => print('Card tapped!'),
              ),
              const SizedBox(height: AppSizes.paddingXL),
              RoundedImageTextCard(
                imagePath: ICON_CONST.upload,
                isSvg: true,
                title: 'Aadhaar Card',
                imageRadius: 12.0,
                imageSize: 60.0,
                titleStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                backgroundColor: Colors.grey[100],
                onTap: () => print('Card tapped!'),
              ),
              const SizedBox(height: AppSizes.paddingXL),
              RoundedImageTextCard(
                imagePath: ICON_CONST.upload,
                isSvg: true,
                title: 'Pan Card',
                imageRadius: 12.0,
                imageSize: 60.0,
                titleStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                backgroundColor: Colors.grey[100],
                onTap: () => print('Card tapped!'),
              ),
              const SizedBox(height: AppSizes.paddingXL),
              RoundedImageTextCard(
                imagePath: ICON_CONST.upload,
                isSvg: true,
                title: 'Upload Any Other Documents',
                imageRadius: 12.0,
                imageSize: 60.0,
                titleStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                backgroundColor: Colors.grey[100],
                onTap: () => print('Card tapped!'),
              ),
            ]),
      ),
    );
  }

  Widget _buildFormSubmit(BuildContext context) {
    return SafeArea(
      child: CoreButton(
          text: 'Upload Documents',
          onPressed: () {
            setState(() {
              _formSubmitted = true;
            });

            if (_formKey.currentState?.validate() ?? false) {
              GoRouter.of(context).push(RouteName.documentsUpload);
            }
          }),
    );
  }
}
