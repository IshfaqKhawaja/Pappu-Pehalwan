import "dart:io";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';

class ShowImage extends StatefulWidget {
  static const routeName = '/show-image';

  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  int flag = 0;
  String url = '';
  List<File> images = [];
  Function? send;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    images = [];
    send;
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (routeArgs.containsKey('flag')) {
      if (mounted) {
        setState(() {
          flag = 1;
          url = routeArgs['image'];
        });
      }
    } else {
      setState(() {        
        images = routeArgs['image'];
        send = routeArgs['send'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('image $images');
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading:const  BackButton(
        //   color: Colors.white,
        // ),
      ),
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: flag == 1
            ? PhotoView(
                imageProvider: CachedNetworkImageProvider(url),
                loadingBuilder: (_, __) => const SpinKitWave(
                  color: Colors.redAccent,
                  size: 10,
                ),
              )
            : const SizedBox(),
      ),
      floatingActionButton: flag == 0
          ? FloatingActionButton(
              onPressed: () => send!(images, context),
              child: const Icon(Icons.send, color: Colors.white),
            )
          : Container(),
    );
  }
}
