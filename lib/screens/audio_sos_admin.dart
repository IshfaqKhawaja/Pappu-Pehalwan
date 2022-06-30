import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'audio_sos.dart';

class AudioSOSAdmin extends StatefulWidget {
  const AudioSOSAdmin({ Key? key }) : super(key: key);

  @override
  State<AudioSOSAdmin> createState() => _AudioSOSAdminState();
}

class _AudioSOSAdminState extends State<AudioSOSAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Audio SOSs',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('audio-sos')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          }
          final data = snapshots.data!.docs;
          if (data.isEmpty) {
            return Center(
              child: Text(
                'No Audios Yet',
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (ctx, index) {
              final tempData = data[index].data()! as Map;
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AudioSOS(
                        scaffoldKey: null,
                        isAdmin: true,
                        userId: data[index].id,
                        username: tempData['username'] ?? 'User',
                      ),
                    ));
                  },
                  title: Text(
                    tempData['username'] ?? 'User',
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    tempData['recentText'] ?? '',
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Text(
                    DateFormat()
                        .add_jm()
                        .format(tempData['createdAt']!.toDate()),
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}