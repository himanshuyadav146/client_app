part of 'document_upload_bloc.dart';

class UploadedDocument {
  final String documentUrl;
  final DocumentType documentType;
  final String fileName;

  UploadedDocument({
    required this.documentUrl,
    required this.documentType,
  }) : fileName = documentUrl.split('/').last;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UploadedDocument &&
              runtimeType == other.runtimeType &&
              documentUrl == other.documentUrl;

  @override
  int get hashCode => documentUrl.hashCode;
}

abstract class DocumentUploadState extends Equatable {
  final Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments;

  const DocumentUploadState({this.uploadedDocuments = const {}});

  @override
  List<Object?> get props => [uploadedDocuments];
}

class DocumentUploadInitial extends DocumentUploadState {
  const DocumentUploadInitial({
    Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments = const {},
  }) : super(uploadedDocuments: uploadedDocuments);

  @override
  List<Object?> get props => [uploadedDocuments];
}

class DocumentUploadInProgress extends DocumentUploadState {
  const DocumentUploadInProgress() : super();
}

class DocumentUploadReady extends DocumentUploadState {
  final File file;
  final DocumentType documentType;
  final DocumentCategory documentCategory;

  const DocumentUploadReady({
    required this.file,
    required this.documentType,
    required this.documentCategory,
  }) : super();

  @override
  List<Object?> get props => [file, documentType, documentCategory];
}

class DocumentUploading extends DocumentUploadState {
  final DocumentCategory documentCategory;

  const DocumentUploading({
    required this.documentCategory,
    Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments = const {},
  }) : super(uploadedDocuments: uploadedDocuments);

  @override
  List<Object?> get props => [documentCategory, uploadedDocuments];
}

class DocumentUploadSuccess extends DocumentUploadState {
  final DocumentCategory documentCategory;
  final UploadedDocument uploadedDocument;

  DocumentUploadSuccess({
    required this.documentCategory,
    required this.uploadedDocument,
    Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments = const {},
  }) : super(uploadedDocuments: {
    ...uploadedDocuments,
    documentCategory: [
      ...?uploadedDocuments[documentCategory],
      uploadedDocument,
    ],
  });

  @override
  List<Object?> get props => [documentCategory, uploadedDocument, uploadedDocuments];
}

class DocumentUploadFailure extends DocumentUploadState {
  final String error;

  const DocumentUploadFailure({required this.error}) : super();

  @override
  List<Object?> get props => [error];
}