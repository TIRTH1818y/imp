import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../UI_widgets/snack_bar.dart';

class pdfviewer extends StatefulWidget {
  final String viewer;
  final String url;
  final String filename;

  const pdfviewer(
      {super.key,
      required this.url,
      required this.filename,
      required this.viewer});

  @override
  State<pdfviewer> createState() => _pdfviewerState();
}

class _pdfviewerState extends State<pdfviewer> {
  PDFDocument? document;
  var _progress = 0.0;

  void _loadPdf() async {
    if (widget.viewer == "Online") {
        final file =
            await PDFDocument.fromURL(widget.url, clearPreviewCache: true);
        setState(() {
          document = file;
        });
    } else if (widget.viewer == "Offline") {
        Directory localfile = Directory("${widget.url}/${widget.filename}");
        File localpath = File(localfile.path);
        final file =
            await PDFDocument.fromFile(localpath, clearPreviewCache: true);
        setState(() {
          document = file;
        });
    }
  }

  Future downloadFile(filename) async {
    try {
      Directory downloadsDir = Directory('/storage/emulated/0/Download');

      Directory imp = Directory("${downloadsDir.path}/IT Material Point");
      if (!await imp.exists()) {
        imp.create();
      }
      final ref = FirebaseStorage.instance.ref("TechnologiesPDF/").child(filename);
      final url = await ref.getDownloadURL();
      String localPath = '${imp.path}/$filename';

      Dio dio = Dio();
      dio.download(url, localPath, onReceiveProgress: (received, total) {
        final progress = (received / total) * 100;
        setState(() {
          _progress = progress;
        });
      });

      print("Download successfully $filename  On $localPath");
      showSnackBar(context, "Download Successfully $filename  On $localPath");
    } catch (e) {
      print(e.toString());
      showSnackBar(context, "Error ${e.toString()}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPdf();
  }

  //final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_progress != 0 && _progress != 100)
            const SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(strokeWidth: 5)),
          const SizedBox(
            width: 5,
          ),
          if (_progress != 0 && _progress != 100)
            Text(
              "${_progress.toStringAsFixed(0)}%  ",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          if (_progress == 0)
           widget.viewer == "Online" ? IconButton(
              onPressed: () async {
                downloadFile(widget.filename);
              },
              icon: const Icon(
                Icons.file_download_outlined,
                color: Colors.black,
              ),
            ) : const Center()
          else if (_progress == 100)
            const Icon(Icons.file_download_done_outlined),
          const SizedBox(
            width: 10,
          )
        ],
        title: Text(
          widget.filename.replaceAll(".pdf", ""),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: document != null
          ? PDFViewer(
              enableSwipeNavigation: true,
              document: document!,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
