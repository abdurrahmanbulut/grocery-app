import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/password_change_screen.dart';
import 'package:grocery_app/screens/profile_update_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text('Profile',
            style:
                TextStyle(color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
        centerTitle: true,
      ),
      body: profileView(context),
    );
  }

  Widget profileView(context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(height: 50),
            CircleAvatar(
              radius: 70,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/1.jpg',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 4),
                  ),
                  Icon(Icons.assignment, color: Colors.amber, size: 24),
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      '   Name Surname',
                      style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: 350,
                child: const Divider(
                  color: Colors.amber,
                  height: 0,
                )),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 4),
                  ),
                  Icon(Icons.account_box, color: Colors.amber, size: 24),
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      '   Username',
                      style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: 350,
                child: const Divider(
                  color: Colors.amber,
                  height: 0,
                )),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 4),
                  ),
                  Icon(Icons.email, color: Colors.amber, size: 24),
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      '   Email',
                      style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: 350,
                child: const Divider(
                  color: Colors.amber,
                  height: 0,
                )),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 4),
                  ),
                  Icon(Icons.phone, color: Colors.amber, size: 24),
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      '   Phone Number',
                      style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: 350,
                child: const Divider(
                  color: Colors.amber,
                  height: 0,
                )),
            EditButton(context),
            Container(
                width: 350,
                child: const Divider(
                  color: Colors.amber,
                  height: 0,
                )),
            PasswordButton(context),
          ],
        ),
      ],
    );
  }
}

MaterialButton EditButton(context) {
  return MaterialButton(
    padding: const EdgeInsets.fromLTRB(40.0, 0.0, 19.22, 0.0),
    onPressed: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfileUpdateScreen()));
    },
    child: Row(children: const [
      Icon(Icons.edit, color: Colors.amber, size: 24),
      Padding(
        padding: EdgeInsets.all(14.0),
        child: Text("   Edit Profile",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontFamily: 'OpenSans')),
      ),
      SizedBox(height: 0, width: 147.5),
      Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 24),
    ]),
  );
}

MaterialButton PasswordButton(context) {
  return MaterialButton(
    padding: const EdgeInsets.fromLTRB(40.0, 0.0, 20.72, 0.0),
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PasswordChangeScreen()));
    },
    child: Row(children: const [
      Icon(Icons.lock_rounded, color: Colors.amber, size: 24),
      Padding(
        padding: EdgeInsets.all(14.0),
        child: Text("   Change Password",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontFamily: 'OpenSans')),
      ),
      SizedBox(height: 0, width: 87),
      Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 24),
    ]),
  );
}
