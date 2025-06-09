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
        fieldName: fileName,
        additionalFields: {
          'category': 'aadhaar',
          'description': 'Aadhaar card upload',
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
          'fileName': fileName,
          'fileUrl': 'https://allindiaitr.in/uploads/$fileName',
        };
      } else {
        throw Exception(
            'Failed to upload document: ${response.statusCode} - $responseData');
      }
    } catch (e) {
      throw Exception('Failed to upload document: ${e.toString()}');
    }
    // try {
    //   final url = Uri.parse(baseUrl + docUpload);
    //   final file = File(filePath);
    //
    //   var request = http.MultipartRequest('POST', url)
    //     ..headers['Authorization'] =
    //         'Bearer eyJhbGdvIjoiSFMyNTYiLCJ0eXBlIjoiSldUIiwiZXhwaXJlIjoxNzc5NjY0OTgyfQ==.eyJpc3MiOiJhbGxpbmRpYWl0ci5pbiIsIm1vYmlsZSI6IjkwOTY0NjQ1MzQiLCJ0aW1lIjoxNzQ4MTA4MDMwfQ==.MjhjZWU0NGQyYzU2YTI2MGEwYTYyYjFhZmRlYWI0OWRhM2U2YjI1OThmZjhkYTIwZjZmNTgzNTQyOGM4ZmUzMA=='
    //     ..fields['fileName'] = fileName
    //     ..fields['userId'] = userId
    //     ..fields['itrId'] = itrId
    //     ..files.add(await http.MultipartFile.fromPath(
    //       'form16_a',
    //       file.path,
    //       filename: fileName,
    //     ));
    //
    //   final response = await request.send();
    //   final responseData = await response.stream.bytesToString();
    //
    //   if (response.statusCode == 200) {
    //     return {
    //       'status': 'success',
    //       'message': 'Document uploaded successfully',
    //       'fileName': fileName,
    //       'fileUrl': 'https://allindiaitr.in/uploads/$fileName',
    //     };
    //   } else {
    //     throw Exception('Failed to upload document: ${response.statusCode} - $responseData');
    //   }
    // } catch (e) {
    //   throw Exception('Failed to upload document: ${e.toString()}');
    // }
  }
}
