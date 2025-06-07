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

// ----------------------
// Abstract State
// ----------------------
abstract class DocumentUploadState extends Equatable {
  final Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments;

  const DocumentUploadState({this.uploadedDocuments = const {}});

  @override
  List<Object?> get props => [uploadedDocuments];
}

// ----------------------
// Initial State
// ----------------------
class DocumentUploadInitial extends DocumentUploadState {
  const DocumentUploadInitial({
    Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments = const {},
  }) : super(uploadedDocuments: uploadedDocuments);
}

// ----------------------
// Picking/Uploading Progress
// ----------------------
class DocumentUploadInProgress extends DocumentUploadState {
  const DocumentUploadInProgress({
    required Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments,
  }) : super(uploadedDocuments: uploadedDocuments);
}

// ----------------------
// Picked File Ready for Upload
// ----------------------
// class DocumentUploadReady extends DocumentUploadState {
//   final File file;
//   final DocumentType documentType;
//   final DocumentCategory documentCategory;
//
//   const DocumentUploadReady({
//     required this.file,
//     required this.documentType,
//     required this.documentCategory,
//     required Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments,
//   }) : super(uploadedDocuments: uploadedDocuments);
//
//   @override
//   List<Object?> get props => [
//     file,
//     documentType,
//     documentCategory,
//     uploadedDocuments,
//   ];
// }

// ----------------------
// Upload in Progress
// ----------------------
class DocumentUploading extends DocumentUploadState {
  final DocumentCategory documentCategory;

  const DocumentUploading({
    required this.documentCategory,
    required Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments,
  }) : super(uploadedDocuments: uploadedDocuments);

  @override
  List<Object?> get props => [documentCategory, uploadedDocuments];
}

// ----------------------
// Upload Success
// ----------------------
class DocumentUploadSuccess extends DocumentUploadState {
  final DocumentCategory documentCategory;
  final List<UploadedDocument> uploadedDocumentsList;

  const DocumentUploadSuccess({
    required this.documentCategory,
    required this.uploadedDocumentsList,
    required Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments,
  }) : super(uploadedDocuments: uploadedDocuments);

  @override
  List<Object?> get props =>
      [documentCategory, uploadedDocumentsList, uploadedDocuments];
}

// ----------------------
// Upload Failure
// ----------------------
class DocumentUploadFailure extends DocumentUploadState {
  final String error;

  const DocumentUploadFailure({
    required this.error,
    required Map<DocumentCategory, List<UploadedDocument>> uploadedDocuments,
  }) : super(uploadedDocuments: uploadedDocuments);

  @override
  List<Object?> get props => [error, uploadedDocuments];
}
