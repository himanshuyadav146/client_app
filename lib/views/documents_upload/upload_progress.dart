import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/documents_upload/document_upload_bloc.dart';

class UploadProgressBar extends StatelessWidget {
  const UploadProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentUploadBloc, DocumentUploadState>(
      builder: (context, state) {
        final totalCategories = 5; // form16a, form16b, aadhaar, pan, other
        int uploadedCategories = state.uploadedDocuments.length;

        // If any category is being uploaded, count it as in progress
        if (state is DocumentUploading) {
          if (!state.uploadedDocuments.containsKey(state.documentCategory)) {
            uploadedCategories++;
          }
        }

        return Column(
          children: [
            LinearProgressIndicator(
              value: uploadedCategories / totalCategories,
              backgroundColor: Colors.grey[200],
              color: Theme.of(context).primaryColor,
              minHeight: 6,
            ),
            const SizedBox(height: 8),
            Text(
              '$uploadedCategories of $totalCategories documents uploaded',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}