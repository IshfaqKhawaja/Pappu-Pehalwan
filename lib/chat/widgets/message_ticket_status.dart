import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageTicketStatus extends StatefulWidget {
  final status;

  const MessageTicketStatus({Key? key, this.status = 0}) : super(key: key);

  @override
  State<MessageTicketStatus> createState() => _MessageTicketStatusState();
}

class _MessageTicketStatusState extends State<MessageTicketStatus> {
  @override
  Widget build(BuildContext context) {
    final status = widget.status;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: status >= 0 ? Colors.yellow : Colors.grey,
              shape: BoxShape.circle),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 2,
            width: 30,
            decoration:
                BoxDecoration(color: status >= 1 ? Colors.blue : Colors.grey),
          ),
        ),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: status >= 1 ? Colors.blue : Colors.grey,
              shape: BoxShape.circle),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
                color: status == 2
                    ? Colors.green
                    : status == 3
                        ? Colors.red
                        : Colors.grey),
          ),
        ),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: status == 2
                  ? Colors.green
                  : status == 3
                      ? Colors.red
                      : Colors.grey,
              shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 10,
        ),
        status == 1
            ? Text("Under Review",
                style:
                    GoogleFonts.openSans(fontSize: 12, color: Colors.grey[600]))
            : status == 2
                ? Text("Accepted",
                    style: GoogleFonts.openSans(
                        fontSize: 12, color: Colors.grey[600]))
                : status == 3
                    ? Text("Rejected",
                        style: GoogleFonts.openSans(
                            fontSize: 12, color: Colors.grey[600]))
                    : Text("Pending",
                        style: GoogleFonts.openSans(
                            fontSize: 12, color: Colors.grey[600]))
      ],
    );
  }
}
