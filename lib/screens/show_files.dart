import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/play_video.dart';
import 'package:photo_view/photo_view.dart';

class ShowFiles extends StatefulWidget {
  static const routeName = '/show-files';

  @override
  _ShowFilesState createState() => _ShowFilesState();
}

class _ShowFilesState extends State<ShowFiles> {
  final _controller = PageController();
  List<Widget> generatePages(files) {
    return List.generate(files.length, (index) {
      String type = files[index].path;

      return Container(
          child: Center(
        child: type.endsWith('.jpg') ||
                type.endsWith('.jpeg') ||
                type.endsWith('.png')
            ? PhotoView(
                imageProvider: Image.file(files[index]).image,
              )
            : type.endsWith('.mp4')
                ? PlayVideo(
                    video: files[index],
                    type: 'file',
                  )
                : Container(
                    child:const  Center(
                      child: Text(
                        'Preview not Present',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    List<File> files = routeArgs['files'];
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: generatePages(files),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
