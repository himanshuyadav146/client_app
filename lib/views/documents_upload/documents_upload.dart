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
import 'package:go_router/go_router.dart';

import '../../core/route/route_name.dart';
import '../../core/utils/enums.dart';

class DocumentsUpload extends StatelessWidget {
  const DocumentsUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentUploadBloc(),
      child: BlocListener<DocumentUploadBloc, DocumentUploadState>(
        listener: (context, state) {
          if (state is DocumentUploadFailure && !state.hasBeenHandled) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
            // Dispatch event to mark this error as handled
            context.read<DocumentUploadBloc>().add(MarkUploadErrorAsHandled());
          }
        },
        child: CoreScaffold(
          title: "Documents Upload",
          appBarBackgroundColor: Theme.of(context).primaryColor,
          appBarForegroundColor: Colors.white, // Added comma here
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
        final uploadedMap = state.uploadedDocuments;

        final documents = uploadedMap[category] ?? [];
        if (documents.isNotEmpty) {
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 4.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final doc = documents[index];
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
                        doc.documentUrl.split('/').last,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        context.read<DocumentUploadBloc>().add(
                          RemoveDocument(
                            category: category,
                            document: doc,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
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
          final uploadedDocuments = state.uploadedDocuments;

          // Define required document categories
          final requiredCategories = [
            DocumentCategory.form16a,
            DocumentCategory.form16b,
            DocumentCategory.aadhaar,
            DocumentCategory.pan,
          ];

          List<String> missingDocuments = [];

          for (var category in requiredCategories) {
            if (!(uploadedDocuments.containsKey(category) &&
                uploadedDocuments[category]!.isNotEmpty)) {
              // Add a user-friendly name for the missing document
              switch (category) {
                case DocumentCategory.form16a:
                  missingDocuments.add("Form 16A");
                  break;
                case DocumentCategory.form16b:
                  missingDocuments.add("Form 16B");
                  break;
                case DocumentCategory.aadhaar:
                  missingDocuments.add("Aadhaar Card");
                  break;
                case DocumentCategory.pan:
                  missingDocuments.add("Pan Card");
                  break;
                default:
                  missingDocuments.add(category.name); // Fallback to enum name
              }
            }
          }

          if (missingDocuments.isEmpty) {
            // All required documents are uploaded
            GoRouter.of(context).push(RouteName.payment);
          } else {
            // Some required documents are missing
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Please upload all required documents: ${missingDocuments.join(', ')}.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
