import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/user_details.dart';
import '../screens/national_plans.dart';
import '../screens/state_plans.dart';
import 'package:provider/provider.dart';

class YojanaScreen extends StatefulWidget {
  const YojanaScreen({Key? key}) : super(key: key);

  @override
  State<YojanaScreen> createState() => _YojanaScreenState();
}

class _YojanaScreenState extends State<YojanaScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<UserDetails>(context, listen: false).getUserDetails;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Government Schemes',
              style:
                  GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            if(userDetails['isAdmin'])
              IconButton(
                  onPressed: () => showModalBottomSheet(
                    enableDrag: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20)
                        )
                      ),
                      context: context,
                      builder: (context) => yojanaBottomSheet(),
                  ),
                  icon: const Icon(Icons.add,color: Colors.white,)
              )
          ],
        ),
        bottom: TabBar(
          controller: tabController,
          labelStyle:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w700),
          tabs: const [
            Tab(
              text: 'उ.प्र सरकारी योजनाएं',
            ),
            Tab(
              text: 'राष्ट्रीय सरकारी योजनाएं',
            ),
          ],
        ),
      ),
      body: TabBarView(
          controller: tabController, children: const [StatesPlans(),NationalPlans()]),
    );
  }

  Widget yojanaBottomSheet() {
    return  ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: InkWell(
                child: CircleAvatar(
                  radius: 50,
                ),
              )
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.7)),
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField(
                style: TextStyle(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  )
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.7)),
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  hintStyle: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  )
                ),
              ),
            ),
            const SizedBox(
              height:
              10,
            ),
            ElevatedButton(
                onPressed: (){},
                child: const Text('Save'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor
              ),
            )
          ],
        ),
      ],
    );
  }
}


