import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/play_video.dart';

class ShowVideoBubble extends StatelessWidget {
  final url;
  final datetime;
  final isMe;
  final read;
  final isNetwork;
  final showDate;
  ShowVideoBubble(
      {this.url, this.datetime, this.isMe, this.read, this.isNetwork = true, this.showDate = false,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: isMe
                ? Colors.lime.withOpacity(0.2)
                : Theme.of(context).primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft:
                  !isMe ? const Radius.circular(0) : const Radius.circular(12),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                height: 280,
                width: 250,
                child: Hero(
                  tag: url,
                  child: isNetwork
                      ? PlayVideo(
                          video: url,
                          type: 'network',
                        )
                      : Stack(
                          children: [
                            Container(
                              child: PlayVideo(
                                video: url,
                                type: 'file',
                              ),
                            ),
                            const Positioned(
                              bottom: 5,
                              right: 5,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.transparent,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          ],
                        ),
                ),
              ),
            if(showDate)
              Column(
                children: [
                  const  SizedBox(
                      height: 6,
                    ),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isMe)
                      Icon(
                        Icons.done_all,
                        size: 22,
                        color: read == 0 ? Colors.grey : Colors.deepPurple,
                      ),
                    Text(
                      DateFormat().add_jm().format(
                            DateTime.parse(datetime),
                          ),
                          style:TextStyle(
                          color: isMe ? Colors.black : Colors.white,
                          fontSize: 12,
                            ),
                    ),
                  ],
                ),
                ],
              ),
                
            ],
          ),
        )
      ],
    );
  }
}
