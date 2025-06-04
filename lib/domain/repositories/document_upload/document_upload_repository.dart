
abstract class DocumentUploadRepository{
  Future<Map<String, dynamic>> uploadDocument({
    required String filePath,
    required String fileName,
    required String userId,
    required String itrId,
  });
}