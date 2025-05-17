part of 'document_upload_bloc.dart';

abstract class DocumentUploadState extends Equatable {
  const DocumentUploadState();

  @override
  List<Object> get props => [];
}

class DocumentUploadInitial extends DocumentUploadState {}

class DocumentUploadInProgress extends DocumentUploadState {}

class DocumentUploadReady extends DocumentUploadState {
  final File file;
  final DocumentType documentType;
  final DocumentCategory documentCategory;

  const DocumentUploadReady({
    required this.file,
    required this.documentType,
    required this.documentCategory,
  });

  @override
  List<Object> get props => [file, documentType, documentCategory];
}

class DocumentUploading extends DocumentUploadState {
  final DocumentCategory documentCategory;

  const DocumentUploading({required this.documentCategory});

  @override
  List<Object> get props => [documentCategory];
}

class DocumentUploadSuccess extends DocumentUploadState {
  final String documentUrl;
  final DocumentType documentType;
  final DocumentCategory documentCategory;

  const DocumentUploadSuccess({
    required this.documentUrl,
    required this.documentType,
    required this.documentCategory,
  });

  @override
  List<Object> get props => [documentUrl, documentType, documentCategory];
}

class DocumentUploadFailure extends DocumentUploadState {
  final String error;

  const DocumentUploadFailure({required this.error});

  @override
  List<Object> get props => [error];
}