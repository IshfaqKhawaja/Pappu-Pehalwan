import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class AudioBubble extends StatefulWidget {
  final url;
  final datetime;
  final isMe;
  final read;
  final isNetwork;
  final showDate;
  const AudioBubble({
    Key? key,
    this.url,
    this.datetime,
    this.isMe,
    this.read,
    this.isNetwork = true,
    this.showDate = false,
  }) : super(key: key);

  @override
  State<AudioBubble> createState() => _AudioBubbleState();
}

class _AudioBubbleState extends State<AudioBubble> {
  FlutterSoundPlayer myPlayer = FlutterSoundPlayer();
  Duration? d;
  bool isPlaying = false;
  void initPlayer() async {
    await myPlayer.openPlayer();
  }

  void startPlayer() async {
    setState(() {
      isPlaying = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    d = await myPlayer.startPlayer(
      codec: Codec.defaultCodec,
      fromURI: widget.url,
      whenFinished: () {
        setState(() {
          isPlaying = false;
        });
      },
    );
    
  }

  void stopPlayer() async {
    setState(() {
      isPlaying = false;
    });
    await myPlayer.stopPlayer();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  void dispose() {
    if (myPlayer != null) {
      myPlayer.closePlayer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 140,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: widget.isMe
                ? Colors.lime.withOpacity(0.2)
                : Theme.of(context).primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: !widget.isMe
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
              bottomRight: widget.isMe
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  !widget.isNetwork
                      ? Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : isPlaying
                          ? SpinKitWave(
                              color: widget.isMe ? Colors.black : Colors.white,
                              size: 16,
                              

                            )
                          : IconButton(
                              onPressed: isPlaying ? stopPlayer : startPlayer,
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color:
                                    widget.isMe ? Colors.black : Colors.white,
                                size: 30,
                              ),
                            ),                  
                ],
              ),
              if (widget.showDate)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // if (widget.isMe)
                    //   Icon(
                    //     Icons.done_all,
                    //     size: 20,
                    //     color: widget.read == 0 ? Colors.grey : Colors.purple,
                    //   ),
                    Text(
                      DateFormat().add_jm().format(
                            DateTime.parse(widget.datetime),
                          ),
                      style: TextStyle(
                        color: widget.isMe ? Colors.black : Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        )
      ],
    );
    ;
  }
}
