import 'package:client_app/domain/repositories/document_upload/document_upload_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client_app/views/documents_upload/upload_progress.dart';
import 'package:client_app/blocs/documents_upload/document_upload_bloc.dart';
import 'package:client_app/core/constant/app_sizes.dart';
import 'package:client_app/core/constant/colors.dart';
import 'package:client_app/core/constant/icon_constant.dart';
import 'package:client_app/core/widgets/core_button.dart';
import 'package:client_app/core/widgets/core_scafold.dart';
import 'package:client_app/core/widgets/document_card.dart';

import '../../core/di/di_container.dart';
import '../../core/utils/enums.dart';

class DocumentsUpload extends StatelessWidget {
  const DocumentsUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DocumentUploadBloc(),
      child: CoreScaffold(
        title: "Documents Upload",
        appBarBackgroundColor: Theme.of(context).primaryColor,
        appBarForegroundColor: Colors.white,
        showBackButton: true,
        body: Padding(
          padding: AppPadding.paddingAllM,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const UploadProgressBar(),
                      const SizedBox(height: AppSizes.paddingXL),
                      _buildDocumentSection(
                        context,
                        title: 'Upload Form - 16 (Part-A)',
                        category: DocumentCategory.form16a,
                        type: DocumentType.pdf,
                      ),
                      const SizedBox(height: AppSizes.paddingXL),
                      _buildDocumentSection(
                        context,
                        title: 'Upload Form - 16 (Part-B)',
                        category: DocumentCategory.form16b,
                        type: DocumentType.pdf,
                      ),
                      const SizedBox(height: AppSizes.paddingXL),
                      _buildDocumentSection(
                        context,
                        title: 'Aadhaar Card',
                        category: DocumentCategory.aadhaar,
                        type: DocumentType.image,
                      ),
                      const SizedBox(height: AppSizes.paddingXL),
                      _buildDocumentSection(
                        context,
                        title: 'Pan Card',
                        category: DocumentCategory.pan,
                        type: DocumentType.image,
                      ),
                      const SizedBox(height: AppSizes.paddingXL),
                      _buildDocumentSection(
                        context,
                        title: 'Upload Any Other Documents',
                        category: DocumentCategory.other,
                        type: DocumentType.pdf,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingS),
              _buildSubmitButton(context),
            ],
          ),
        ),
        backgroundColor: kDocumentBackgroundColor,
        isDrawer: false,
        isResizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _buildDocumentSection(
    BuildContext context, {
    required String title,
    required DocumentCategory category,
    required DocumentType type,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DocumentCard(
          imagePath: ICON_CONST.upload,
          isSvg: true,
          title: title,
          documentCategory: category,
          documentType: type,
          imageRadius: 12.0,
          imageSize: 60.0,
        ),
        const SizedBox(height: AppSizes.paddingM),
        _buildUploadStatusForCategory(context, category),
      ],
    );
  }

  Widget _buildUploadStatusForCategory(
    BuildContext context,
    DocumentCategory category,
  ) {
    return BlocBuilder<DocumentUploadBloc, DocumentUploadState>(
      builder: (context, state) {
        if (state is DocumentUploadSuccess &&
            state.documentCategory == category) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.paddingM),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(AppSizes.paddingS),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
                const SizedBox(width: AppSizes.paddingS),
                Expanded(
                  child: Text(
                    'Uploaded: ${state.documentUrl.split('/').last}',
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () {
                    context.read<DocumentUploadBloc>().add(
                          RemoveDocument(),
                        );
                  },
                ),
              ],
            ),
          );
        } else if (state is DocumentUploading &&
            state.documentCategory == category) {
          return LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            color: Theme.of(context).primaryColor,
            minHeight: 6,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SafeArea(
      child: CoreButton(
        text: 'Submit Documents',
        onPressed: () {
          final state = context.read<DocumentUploadBloc>().state;
          if (state is DocumentUploadSuccess) {
            //GoRouter.of(context).push(RouteName.documentsVerification);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Please upload all required documents')),
            );
          }
        },
      ),
    );
  }
}
