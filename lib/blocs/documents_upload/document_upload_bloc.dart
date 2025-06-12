import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/di/di_container.dart';
import '../../core/utils/enums.dart';
import '../../domain/repositories/document_upload/document_upload_repository.dart';
import '../../services/session_manager/session_manager.dart';

part 'document_upload_event.dart';
part 'document_upload_state.dart';

class DocumentUploadBloc extends Bloc<DocumentUploadEvent, DocumentUploadState> {
  final DocumentUploadRepository documentUploadRepository = getIt<DocumentUploadRepository>();
  final ImagePicker _imagePicker = ImagePicker();
  final FilePicker _filePicker = FilePicker.platform;
  final SessionController sessionController = getIt<SessionController>();

  // Map to store documents by category
  final Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments = {};

  DocumentUploadBloc() : super(DocumentUploadInitial(uploadedDocuments: {})) {
    on<PickDocument>(_onPickDocument);
    on<UploadDocument>(_onUploadDocument);
    on<RemoveDocument>(_onRemoveDocument);
  }

  Future<void> _onPickDocument(
      PickDocument event,
      Emitter<DocumentUploadState> emit,
      ) async {
    try {
      emit(DocumentUploadInProgress(uploadedDocuments: {}));

      File? file;

      if (event.source == DocumentSource.camera) {
        final pickedFile = await _imagePicker.pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
          imageQuality: 85,
        );
        if (pickedFile != null) {
          file = File(pickedFile.path);
        }
      } else if (event.source == DocumentSource.gallery) {
        if (event.documentType == DocumentType.image) {
          final pickedFile = await _imagePicker.pickImage(
            source: ImageSource.gallery,
            maxWidth: 1800,
            maxHeight: 1800,
            imageQuality: 85,
          );
          if (pickedFile != null) {
            file = File(pickedFile.path);
          }
        } else {
          final result = await _filePicker.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
          );
          if (result != null) {
            file = File(result.files.single.path!);
          }
        }
      }

      if (file != null) {
        // Instead of emitting DocumentUploadReady, directly call upload event
        add(UploadDocument(
          file: file,
          documentType: event.documentType,
          documentCategory: event.documentCategory,
        ));
      } else {
        emit(const DocumentUploadInitial());
      }
    } catch (e) {
      // emit(DocumentUploadFailure(error: e.toString()));
    }
  }


  Future<void> _onUploadDocument(UploadDocument event, Emitter<DocumentUploadState> emit) async {
    try {
      emit(DocumentUploading(
        documentCategory: event.documentCategory,
        uploadedDocuments: uploadedDocuments,
      ));

      // // Simulated delay for upload
      // await Future.delayed(const Duration(seconds: 2));


     // Access userId and itrId from SessionController
     final userId = sessionController.getUserId(); // Assuming getUserId() method exists
     final itrId = sessionController.getItrId(); // Assuming getItrId() method exists

     final response = await documentUploadRepository.uploadDocument(
          filePath: event.file.path,
          fileName: event.documentCategory.name,
          userId: userId ?? "defaultUserId", // Provide a default or handle null appropriately
          itrId: itrId ?? "defaultItrId", // Provide a default or handle null appropriately
     );

      // Get the fileUrl from the response
      final fileUrl = response['fileUrl'] as String?;

      final category = event.documentCategory;
      final documents = uploadedDocuments[category] ?? [];

      if (fileUrl != null) {
        documents.add(
          UploadedDocument(
            documentUrl: fileUrl, // Use the actual fileUrl from the response
            documentType: event.documentType,
          ),
        );

        uploadedDocuments[category] = documents;
      } else {
        // Handle the case where fileUrl is null, perhaps emit a failure state
        // For now, just printing an error or logging
        print("Error: fileUrl is null after upload.");
      }

      emit(DocumentUploadSuccess(
        documentCategory: category,
        uploadedDocumentsList: documents,
        uploadedDocuments: uploadedDocuments,
      ));
    } catch (e) {
      emit(DocumentUploadFailure(error: e.toString(), uploadedDocuments: uploadedDocuments));
    }
  }

  void _onRemoveDocument(
      RemoveDocument event,
      Emitter<DocumentUploadState> emit,
      ) {
    // Clone current map
    final currentDocuments = Map<DocumentCategory, List<UploadedDocument>>.from(
      state.uploadedDocuments,
    );

    // Clone the specific category list
    final docsInCategory = List<UploadedDocument>.from(
      currentDocuments[event.category] ?? [],
    );

    // Remove the specific document
    docsInCategory.removeWhere((doc) => doc.documentUrl == event.document.documentUrl);

    // Update the map
    currentDocuments[event.category] = docsInCategory;

    emit(DocumentUploadSuccess(
      documentCategory: event.category,
      uploadedDocumentsList: docsInCategory,
      uploadedDocuments: currentDocuments,
    ));
  }

}
