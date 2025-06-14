import 'package:client_app/config/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../../domain/repositories/document_upload/document_upload_repository.dart';
import '../../network/network_service_api.dart';

class DocumentRepositoryImpl implements DocumentUploadRepository {
  final _api = NetworkServiceApi();

  // @override
  // Future<Map<String, dynamic>> uploadDocument({
  //   required String filePath,
  //   required String fileName,
  //   required String userId,
  //   required String itrId,
  // }) async {
  //   try {
  //     final response = await _api.uploadFile(
  //       baseUrl + docUpload,
  //       filePath: filePath,
  //       fieldName: fileName, // This 'fileName' is the field name for the file itself, e.g. 'form16_a'
  //       additionalFields: {
  //         'userId': userId,
  //         'itrId': itrId,
  //         // This 'fileName' is the descriptive name, using the method parameter 'fileName'
  //         // which comes from event.documentCategory.name
  //         'fileName': fileName,
  //       },
  //       onProgress: (sent, total) {
  //         print('Upload progress: ${(sent / total * 100).toStringAsFixed(1)}%');
  //       },
  //     );
  //     final responseData = await response.stream.bytesToString();
  //
  //     if (response.statusCode == 200) {
  //       return {
  //         'status': 'success',
  //         'message': 'Document uploaded successfully',
  //         'fileName': fileName,
  //         'fileUrl': 'https://allindiaitr.in/uploads/$fileName',
  //       };
  //     } else {
  //       throw Exception(
  //           'Failed to upload document: ${response.statusCode} - $responseData');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to upload document: ${e.toString()}');
  //   }
  // }


  @override
  Future<Map<String, dynamic>> uploadDocument({
  required String filePath,
  required String fileName,
  required String userId,
  required String itrId,
  }) async {
    try {
      // Verify file exists first
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('File does not exist at path: $filePath');
      }

      final response = await _api.uploadFile(
        baseUrl + docUpload,
        filePath: filePath,
        fieldName: 'form16_a',
        additionalFields: {
          'userId': userId,
          'itrId': itrId,  // Descriptive category name
          'fileName': fileName,  // Actual filename
          // 'fileName': file.path.split('/').last,  // Actual filename
        },
        onProgress: (sent, total) {
          print('Upload progress: ${(sent / total * 100).toStringAsFixed(1)}%');
        },
      );

      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return {
          'status': 'success',
          'message': 'Document uploaded successfully',
          // 'category': documentCategory,
          'fileUrl': 'https://allindiaitr.in/uploads/${file.path.split('/').last}',
        };
      } else {
        throw Exception(
            'Failed to upload document: ${response.statusCode} - $responseData');
      }
    } catch (e) {
      throw Exception('Failed to upload document: ${e.toString()}');
    }
  }
}
