import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

part 'document_upload_event.dart';
part 'document_upload_state.dart';

class DocumentUploadBloc extends Bloc<DocumentUploadEvent, DocumentUploadState> {
  DocumentUploadBloc() : super(DocumentUploadInitial()) {
    on<PickDocument>(_onPickDocument);
    on<UploadDocument>(_onUploadDocument);
    on<RemoveDocument>(_onRemoveDocument);
  }

  Future<void> _onPickDocument(
      PickDocument event,
      Emitter<DocumentUploadState> emit,
      ) async {
    try {
      emit(DocumentUploadInProgress());

      File? file;
      if (event.source == DocumentSource.camera) {
        final pickedFile = await ImagePicker().pickImage(
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
          final pickedFile = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            maxWidth: 1800,
            maxHeight: 1800,
            imageQuality: 85,
          );
          if (pickedFile != null) {
            file = File(pickedFile.path);
          }
        } else {
          final result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
          );
          if (result != null) {
            file = File(result.files.single.path!);
          }
        }
      }

      if (file != null) {
        emit(DocumentUploadReady(
          file: file,
          documentType: event.documentType,
          documentCategory: event.documentCategory,
        ));
      } else {
        emit(DocumentUploadInitial());
      }
    } catch (e) {
      emit(DocumentUploadFailure(error: e.toString()));
    }
  }

  Future<void> _onUploadDocument(
      UploadDocument event,
      Emitter<DocumentUploadState> emit,
      ) async {
    try {
      emit(DocumentUploading(documentCategory: event.documentCategory));
      // Mock upload - replace with actual API call
      await Future.delayed(const Duration(seconds: 2));
      emit(DocumentUploadSuccess(
        documentUrl: 'https://example.com/${event.file.path.split('/').last}',
        documentType: event.documentType,
        documentCategory: event.documentCategory,
      ));
    } catch (e) {
      emit(DocumentUploadFailure(error: e.toString()));
    }
  }

  void _onRemoveDocument(
      RemoveDocument event,
      Emitter<DocumentUploadState> emit,
      ) {
    emit(DocumentUploadInitial());
  }
}