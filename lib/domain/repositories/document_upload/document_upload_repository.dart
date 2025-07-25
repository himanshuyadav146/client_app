
abstract class DocumentUploadRepository{
  Future<Map<String, dynamic>> uploadDocument({
    required String filePath,
    required String fileName,
    required String userId,
    required String itrId,
  });

  Future<Map<String, dynamic>> deleteDocument({
    required String docId,
    required String userId,
    required String itrId,
    required String fileName,
    required String token,
  });
}