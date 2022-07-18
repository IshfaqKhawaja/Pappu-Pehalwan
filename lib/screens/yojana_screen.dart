import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pappupehalwan/screens/national_plans.dart';
import 'package:pappupehalwan/screens/state_plans.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Government Schemes',
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        bottom: TabBar(
          controller: tabController,
          labelStyle:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w700),
          tabs: [
            Tab(
              text: 'राजकीय योजनाएं',
            ),
            Tab(
              text: 'राष्ट्रीय योजनाएं',
            ),
          ],
        ),
      ),
      body: TabBarView(
          controller: tabController, children: [StatesPlans(),NationalPlans()]),
    );
  }
}

