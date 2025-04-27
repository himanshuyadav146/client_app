import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadProgressBar extends StatelessWidget {
  const UploadProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("uploading documents....");
    // return BlocBuilder<DocumentUploadBloc, DocumentUploadState>(
    //   builder: (context, state) {
    //     return Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               'Pending (${state.pendingDocuments.length})',
    //               style: const TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             Text(
    //               'Uploaded (${state.uploadedDocuments.length})',
    //               style: const TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //           ],
    //         ),
    //         const SizedBox(height: 8),
    //         LinearProgressIndicator(
    //           value: state.uploadedDocuments.length /
    //               (state.uploadedDocuments.length + state.pendingDocuments.length),
    //           backgroundColor: Colors.grey[200],
    //           valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}