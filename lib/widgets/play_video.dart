import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  final video;
  final type;
  PlayVideo({this.video, this.type});

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  var playerWidget;
  var videoPlayerController;
  ChewieController? chewieController;
  var player;
  bool startUp = true;

  Future<Widget> videoPlay() async {
    videoPlayerController =
        widget.type.toString().toUpperCase() == 'file'.toUpperCase()
            ? VideoPlayerController.file(widget.video)
            : VideoPlayerController.network(widget.video);

    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      placeholder: Center(
        child: Icon(
          Icons.play_arrow,
          size: 50,
          color: Theme.of(context).errorColor,
        ),
      ),
      autoPlay: false,
      looping: false,
      allowFullScreen: false,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      
    );

    playerWidget = Chewie(
      controller: chewieController as ChewieController,
    );
    return playerWidget;
  }

//Using cached controller:
  // CachedVideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    videoPlay().then((value) {
      setState(() {
        player = value;
      });
    });
    // if (widget.type.toString().toUpperCase() == 'network'.toUpperCase()) {
    //   controller = CachedVideoPlayerController.network(widget.video);
    //   controller!.initialize().then((_) {});
    // }
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    // controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return player == null
    //     ? Container(
    //         height: chewieController != null
    //       ? chewieController!.videoPlayerController.value.size.height
    //       : null,
    //         child: Center(
    //           child: Icon(
    //             Icons.play_arrow,
    //             size: 50,
    //             color: Theme.of(context).errorColor,
    //           ),
    //         ),
    //       )
    //     : widget.type.toString().toUpperCase() == 'file'.toUpperCase()
    //         ? Container(
    //             child: player,
    //           )
    //         : InkWell(
    //             onTap: () {
    //               // controller!.value.isPlaying
    //               //     ? controller!.pause()
    //               //     : controller!.play();
    //               chewieController!.isPlaying
    //                   ? chewieController!.pause()
    //                   : chewieController!.play();
    //             },
    //             child: player,
    //           );
    return Container(
      height: chewieController != null
          ? chewieController!.videoPlayerController.value.size.height
          : null,
      child: chewieController != null &&
              chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(
              controller: chewieController!,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Container(
                  height: 280,
                  child: const  Center(
                    child:  SpinKitCircle(
                      color: Colors.black,
                      size: 50,
                    
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
