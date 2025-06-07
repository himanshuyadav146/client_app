import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client_app/core/constant/app_sizes.dart';
import 'package:client_app/core/widgets/core_text.dart';
import 'package:client_app/core/widgets/document_picker_bottom_sheet.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/documents_upload/document_upload_bloc.dart';
import '../utils/enums.dart';

class DocumentCard extends StatelessWidget {
  final String title;
  final DocumentCategory documentCategory;
  final DocumentType documentType;
  final String? imagePath;
  final bool isSvg;
  final double imageRadius;
  final double imageSize;
  final TextStyle? titleStyle;
  final Color? backgroundColor;

  const DocumentCard({
    super.key,
    required this.title,
    required this.documentCategory,
    required this.documentType,
    this.imagePath,
    this.isSvg = false,
    this.imageRadius = 12.0,
    this.imageSize = 60.0,
    this.titleStyle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentUploadBloc, DocumentUploadState>(
      listener: (context, state) {
        if (state is DocumentUploadFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
        // else if (state is DocumentUploadReady) {
        //   // Auto-upload when file is selected
        //   context.read<DocumentUploadBloc>().add(UploadDocument(
        //     file: state.file,
        //     documentType: state.documentType,
        //     documentCategory: state.documentCategory,
        //   ));
        // }
      },
      builder: (context, state) {
        final isCurrentDocument = state is DocumentUploadSuccess &&
            state.documentCategory == documentCategory;
        final isUploading = state is DocumentUploading &&
            state.documentCategory == documentCategory;

        return SizedBox(
          width: double.infinity,
          child: Card(
            color: backgroundColor ?? Colors.grey[100],
            child: InkWell(
              onTap: () {
                showDocumentPickerBottomSheet(
                  context: context,
                  documentCategory: documentCategory,
                  documentType: documentType,
                  onSourceSelected: (source) {
                    context.read<DocumentUploadBloc>().add(PickDocument(
                      source: source,
                      documentType: documentType,
                      documentCategory: documentCategory,
                    ));
                  },
                );
              },
              child: Padding(
                padding: AppPadding.paddingAllM,
                child: Column(
                  children: [
                    if (imagePath != null)
                      isSvg
                          ? SvgPicture.asset(
                        imagePath!,
                        height: imageSize,
                        width: imageSize,
                      )
                          : Image.asset(
                        imagePath!,
                        height: imageSize,
                        width: imageSize,
                      ),
                    const SizedBox(height: AppSizes.paddingS),
                    CoreLevel(
                      text: title,
                      style: titleStyle ??
                          const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}