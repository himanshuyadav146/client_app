import 'package:http/http.dart' as http;
import 'dart:io';

import '../../../domain/repositories/document_upload/document_upload_repository.dart';


class DocumentRepositoryImpl implements DocumentUploadRepository {
  @override
  Future<Map<String, dynamic>> uploadDocument({
    required String filePath,
    required String fileName,
    required String userId,
    required String itrId,
  }) async {
    try {
      final url = Uri.parse('https://allindiaitr.in/add_documents.php');
      final file = File(filePath);

      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] =
            'Bearer eyJhbGdvIjoiSFMyNTYiLCJ0eXBlIjoiSldUIiwiZXhwaXJlIjoxNzc5NjY0OTgyfQ==.eyJpc3MiOiJhbGxpbmRpYWl0ci5pbiIsIm1vYmlsZSI6IjkwOTY0NjQ1MzQiLCJ0aW1lIjoxNzQ4MTA4MDMwfQ==.MjhjZWU0NGQyYzU2YTI2MGEwYTYyYjFhZmRlYWI0OWRhM2U2YjI1OThmZjhkYTIwZjZmNTgzNTQyOGM4ZmUzMA=='
        ..fields['fileName'] = fileName
        ..fields['userId'] = userId
        ..fields['itrId'] = itrId
        ..files.add(await http.MultipartFile.fromPath(
          'form16_a',
          file.path,
          filename: fileName,
        ));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return {
          'status': 'success',
          'message': 'Document uploaded successfully',
          'fileName': fileName,
          'fileUrl': 'https://allindiaitr.in/uploads/$fileName',
        };
      } else {
        throw Exception('Failed to upload document: ${response.statusCode} - $responseData');
      }
    } catch (e) {
      throw Exception('Failed to upload document: ${e.toString()}');
    }
  }
}