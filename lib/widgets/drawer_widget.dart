import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/profile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(       
      semanticLabel: 'Pappu Pehalwan',
      backgroundColor: Theme.of(context).backgroundColor,
      child: ListView(
        children: [
          AppBar(
            title: Column(
           children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(64),
               child: Image.asset(
                 'assets/images/icon.jpg',
                 height: 120,
                 fit: BoxFit.cover,
                 width: 120,
               
               ),
             ),
             const SizedBox(
               height: 10,
             ),
             Text('पप्पू पहलवान', style: GoogleFonts.openSans(
               color: Colors.white,
               fontSize: 24,
               fontWeight: FontWeight.w800,
             ),),
            
             
           ],
           
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        centerTitle: true,
          ),
          
        // Header End:
        const SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text('Profile', style: GoogleFonts.openSans(
            color: Theme.of(context).primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),

          ),
          leading: Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
          ),
          onTap: () {
            Navigator.of(context).push(

            MaterialPageRoute(
              
              builder: (context) => Profile(
                
              ),
            ),
            );
           
          },
          focusColor: Theme.of(context).primaryColor,
          hoverColor: Theme.of(context).primaryColor,
          mouseCursor: MaterialStateMouseCursor.clickable,
         
              ),
        
            
        
        ],

      ),
    );
  }
}
