import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

class FilePickerScreen extends StatefulWidget {
  const FilePickerScreen({super.key});
  @override
  State<FilePickerScreen> createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  File? userImageFile;
  FilePickerResult? _result1, _result2;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFECF6FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF01204E),
        title: const Text('Document Screen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getImageField(
                  context, 'Profile Picutre :', _pickFile, 1, _result1),
              SizedBox(height: size.height * .04),
              _getImageField(context, "NID Card :", _pickFile, 2, _result2),
            ],
          ),
        ),
      ),
    );
  }

  void _pickFile(int key) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // final pickedFile = File(result.files.single.path!);
      // final file = result.files.first;
      // print("size: ${file.size}");
      // print("size: ${file.extension}");
      // print("size: ${file.path}");
      if (key == 1) {
        _result1 = result;
      } else {
        _result2 = result;
      }
      setState(() {});
    }
  }

  Widget _getImageField(BuildContext context, String title, Function fun,
      int key, FilePickerResult? result) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: size.height * .32,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * .7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.white30,
                              Color(0xB3FFFFFF),
                              Color(0x62FFFFFF)
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 144, 176, 208),
                              blurRadius: 40,
                              offset: Offset(5, 2),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 40,
                              offset: Offset(-5, -2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            _getExtension(result),
                            style: TextStyle(
                              fontSize: result != null ? 40 : 14,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_getName(result)),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: OutlinedButton(
                    onPressed: () => fun(key),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF01204E),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getName(FilePickerResult? result) {
    if (result == null) {
      return "";
    } else {
      return result.files.first.name;
    }
  }

  String _getExtension(FilePickerResult? result) {
    if (result == null) {
      return "No File Added Yet!";
    } else {
      return ".${result.files.first.extension!}";
    }
  }
}
