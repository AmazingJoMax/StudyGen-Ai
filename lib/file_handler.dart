import 'package:external_path/external_path.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:markdown/markdown.dart';
// import 'package:share_plus/share_plus.dart';

class FileHandler {
  String? generatedPdfFilePath;

  final _flutterNativeHtmlToPdfPlugin = FlutterNativeHtmlToPdf();
  String? name;
  String? md;

  void convertToPDF(List<String> book) {
    name = book[0];
    md = book[1];
    parseMarkdown(md!);
  }

  void parseMarkdown(String md) {
    var html = markdownToHtml(md);
    generatePdfDocument(html);
  }

  Future<void> generatePdfDocument(String html) async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    String targetPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOCUMENTS);
    // final targetPath = appDocDir.path;
    var targetFileName = name;
    var status = await Permission.storage.status;
    if (status.isGranted) {
      final generatedPdfFile =
          await _flutterNativeHtmlToPdfPlugin.convertHtmlToPdf(
        html: html,
        targetDirectory: targetPath,
        targetName: targetFileName!,
      );

      generatedPdfFilePath = generatedPdfFile?.path;
      // OpenFilex.open(generatedPdfFilePath!);
      print(generatedPdfFilePath);
    } else {
      await Permission.storage.request();
    }
  }

  void shareFile(book) async {
    // if (generatedPdfFilePath == null) {
    //   convertToPDF(book);
    //   shareFile(book);
    // } else {
    //   await Share.shareXFiles([XFile(generatedPdfFilePath!)]);
    // }
  }
}
