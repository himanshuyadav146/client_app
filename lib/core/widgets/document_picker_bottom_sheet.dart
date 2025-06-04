
import 'package:flutter/material.dart';

import '../../blocs/documents_upload/document_upload_bloc.dart';
import '../utils/enums.dart';

void showDocumentPickerBottomSheet({
  required BuildContext context,
  required DocumentCategory documentCategory,
  required DocumentType documentType,
  required Function(DocumentSource) onSourceSelected,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                onSourceSelected(DocumentSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(
                documentType == DocumentType.image
                    ? 'Choose from Gallery'
                    : 'Choose Document',
              ),
              onTap: () {
                Navigator.pop(context);
                onSourceSelected(DocumentSource.gallery);
              },
            ),
          ],
        ),
      );
    },
  );
}