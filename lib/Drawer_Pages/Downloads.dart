import 'dart:io';
import 'package:flutter/material.dart';
import 'package:itmaterialspoint/Services/pdfviewer.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  @override
  void initState() {
    super.initState();
    Load_Pdfs();
  }

  Future<void> Load_Pdfs() async {
    Directory downloadsDir = Directory('/storage/emulated/0/Download');

    Directory imp = Directory("${downloadsDir.path}/IT Material Point/");
    if (!await imp.exists()) {
      imp.create();
    }
    final pdfFiles = imp
        .listSync()
        .where((element) => element.path.endsWith('.pdf'))
        .map((element) => File(element.path))
        .toList();
    setState(() {
      PDFFiles = pdfFiles;
    });
  }

  List<File> PDFFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
      ),
      body: PDFFiles.isNotEmpty
          ? ListView.builder(
              itemCount: PDFFiles.length,
              itemBuilder: (context, index) {
                final pdfFile = PDFFiles[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey.shade50,
                    child: InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pdfviewer(
                              viewer: "Offline",
                              filename: pdfFile.path.split('/').last.toString(),
                              url:
                                  "/storage/emulated/0/Download/IT Material Point",
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.picture_as_pdf_rounded,
                                color: Colors.red,
                                size: 40,
                              ),
                              title: Text(
                                pdfFile.path.split('/').last,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text("No Downloaded Files Found."),
            ),
    );
  }
}
