import 'package:client_app/config/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../../domain/repositories/document_upload/document_upload_repository.dart';
import '../../network/network_service_api.dart';

class DocumentRepositoryImpl implements DocumentUploadRepository {
  final _api = NetworkServiceApi();

  @override
  Future<Map<String, dynamic>> uploadDocument({
    required String filePath,
    required String fileName,
    required String userId,
    required String itrId,
  }) async {
    try {
      final response = await _api.uploadFile(
        baseUrl + docUpload,
        filePath: filePath,
        fieldName: fileName, // field name for file
        additionalFields: {
          'userId': userId,
          'itrId': itrId,
          'fileName': fileName,
        },
        onProgress: (sent, total) {
          print('Upload progress: ${(sent / total * 100).toStringAsFixed(1)}%');
        },
      );

      // ✅ Now use response directly
      if (response['status'] == 'success') {
        return {
          'status': 'success',
          'message': response['message'],
          'fileName': response['fileName'],
          'fileUrl': 'https://allindiaitr.in/uploads/${response['fileName']}',
        };
      } else {
        throw Exception('Upload failed: ${response['message']}');
      }
    } catch (e) {
      throw Exception('Failed to upload document: ${e.toString()}');
    }
  }
}
