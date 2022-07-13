import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Groups extends StatefulWidget {
  final scaffoldKey;
  const Groups({Key? key, this.scaffoldKey,}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  List groups = [
    {
      'title': 'Exploring Himanchal',
      'type': 'NEWS',
      'members': 189,
      'joinLink': '',
      'image': 'assets/images/Himachal.jpeg'
    },
    {
      'title': 'Mradubhashi Update',
      'type': 'NEWS',
      'members': 201,
      'joinLink': '',
      'image': 'assets/images/group_icon1.jpeg'

    },
    {
      'title': 'CG E',
      'type': 'NEWS',
      'members': 205,
      'joinLink': '',
      'image': 'assets/images/group_icon2.jpeg'

    },
    {
      'title': 'Nutrilite Consultant',
      'type': 'NEWS',
      'members': 0,
      'joinLink': '171',
      'image': 'assets/images/group_icon3.jpeg'

    },
    {
      'title': 'Love From Himanchal',
      'type': 'NEWS',
      'members': 200,
      'joinLink': '',
      'image': 'assets/images/group_icon4.jpeg'

    },
  ];

  Widget makeGroupCard(title, type, members, joinLink, image) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 27,
            
            child: CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage(image),
               ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                type,
                style: GoogleFonts.openSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Icon(
                    Icons.group,
                    color: Theme.of(context).primaryColor,
                    size: 27,
                  ),
                   const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 4,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '$members Members',
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
              )
                ],
              ),
             
            ]
            ),
          ),
          // const Spacer(),
            MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color(0xff215980),
              onPressed: () {},
              child: Text(
                'Join',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return makeGroupCard(
            groups[index]['title'],
            groups[index]['type'],
            groups[index]['members'],
            groups[index]['joinLink'],
            groups[index]['image'],
          );
        });
  }
}
