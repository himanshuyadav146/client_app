part of 'document_upload_bloc.dart';

abstract class DocumentUploadEvent extends Equatable {
  const DocumentUploadEvent();

  @override
  List<Object?> get props => [];
}

class PickDocument extends DocumentUploadEvent {
  final DocumentSource source;
  final DocumentType documentType;
  final DocumentCategory documentCategory;

  const PickDocument({
    required this.source,
    required this.documentType,
    required this.documentCategory,
  });

  @override
  List<Object?> get props => [source, documentType, documentCategory];
}

class UploadDocument extends DocumentUploadEvent {
  final File file;
  final DocumentType documentType;
  final DocumentCategory documentCategory;

  const UploadDocument({
    required this.file,
    required this.documentType,
    required this.documentCategory,
  });

  @override
  List<Object?> get props => [file, documentType, documentCategory];
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