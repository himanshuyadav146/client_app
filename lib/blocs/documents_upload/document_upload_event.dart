part of 'document_upload_bloc.dart';

abstract class DocumentUploadEvent extends Equatable {
  const DocumentUploadEvent();

  @override
  List<Object?> get props => [];
}

class PickDocument extends DocumentUploadEvent {
  final DocumentSource source;
  final DocumentCategory documentCategory;
  final DocumentType documentType;

  const PickDocument({
    required this.source,
    required this.documentCategory,
    required this.documentType,
  });

  @override
  List<Object?> get props => [source, documentCategory, documentType];
}

class UploadDocument extends DocumentUploadEvent {
  final File file;
  final DocumentCategory documentCategory;
  final DocumentType documentType;

  const UploadDocument({
    required this.file,
    required this.documentCategory,
    required this.documentType,
  });

  @override
  List<Object?> get props => [file, documentCategory, documentType];
}

class RemoveDocument extends DocumentUploadEvent {
  final DocumentCategory category;
  final UploadedDocument document;

  const RemoveDocument({
    required this.category,
    required this.document,
  });

  @override
  List<Object?> get props => [category, document];
}

class MarkUploadErrorAsHandled extends DocumentUploadEvent {}

class DeleteDocument extends DocumentUploadEvent {
  final DocumentCategory category;
  final UploadedDocument document;
  final String docId;
  final String userId;
  final String itrId;
  final String fileName;
  final String token;

  DeleteDocument({
    required this.category,
    required this.document,
    required this.docId,
    required this.userId,
    required this.itrId,
    required this.fileName,
    required this.token,
  });

  @override
  List<Object?> get props => [category, document, docId, userId, itrId, fileName, token];
}
