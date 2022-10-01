
import 'package:flutter/material.dart';

import '../../Constants/constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/Screenshot_2022-06-24-00-43-24-963_com.whatsapp.jpg'),
              ),
              accountName: Text('Midhun Mohan'),
              accountEmail: Text('midhunmohan911@gmail.com')),
          ListTile(
            title: Text(
              'Home',
              style: TextStyle(color: kWhite),
            ),
          ),
          ListTile(
            title: Text(
              'About',
              style: TextStyle(color: kWhite),
            ),
          ),
          ListTile(
            title: Text(
              'Contact us',
              style: TextStyle(color: kWhite),
            ),
          ),
        ],
      ),
    );
  }
}
