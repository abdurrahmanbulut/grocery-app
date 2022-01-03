import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/password_change_screen.dart';
import 'package:grocery_app/screens/profile_update_screen.dart';
import 'package:grocery_app/services/database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    ValueNotifier<AppUser> valueNotifier = ValueNotifier<AppUser>(appUser);
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
                child: (appUser.image.isEmpty)? Image.asset(
                  'assets/images/1.jpg',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ) :
                Image.network(
                  appUser.image,
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
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 4),
                  ),
                  const Icon(Icons.assignment, color: Colors.amber, size: 24),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: (appUser.name.isEmpty)? const Text(
                      '   Name Surname',
                      style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    ) : Text(
                      '   '+ appUser.name,
                      style: const TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
                width: 350,
                child: Divider(
                  color: Colors.amber,
                  height: 0,
                )),
            const SizedBox(
                width: 350,
                child: Divider(
                  color: Colors.amber,
                  height: 0,
                )),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 4),
                  ),
                  const Icon(Icons.email, color: Colors.amber, size: 24),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                    '   '+ appUser.email,
                    style: const TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
                width: 350,
                child: Divider(
                  color: Colors.amber,
                  height: 0,
                )),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 4),
                  ),
                  const Icon(Icons.phone, color: Colors.amber, size: 24),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: (appUser.phoneNumber.isEmpty)? const Text(
                      '   Phone Number',
                      style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    ): Text(
                      '   '+ appUser.phoneNumber,
                      style: const TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
                width: 350,
                child: Divider(
                  color: Colors.amber,
                  height: 0,
                )),
            editButton(context),
            const SizedBox(
                width: 350,
                child: Divider(
                  color: Colors.amber,
                  height: 0,
                )),
            (appUser.password.isNotEmpty)? passwordButton(context) : Container(),
          ],
        ),
      ],
    );
  }

  MaterialButton editButton(context) {
    return MaterialButton(
      padding: const EdgeInsets.fromLTRB(40.0, 0.0, 19.22, 0.0),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfileUpdateScreen())).then((value) {setState(() {});});
      },
      child: Row(children: const [
        Icon(Icons.edit, color: Colors.amber, size: 24),
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Text("   Edit Profile",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontFamily: 'OpenSans')),
        ),
        SizedBox(height: 0, width: 113),
        Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 24),
      ]),
    );
  }

  MaterialButton passwordButton(context) {
    return MaterialButton(
      padding: const EdgeInsets.fromLTRB(40.0, 0.0, 20.72, 0.0),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PasswordChangeScreen()));
      },
      child: Row(children: const [
        Icon(Icons.lock_rounded, color: Colors.amber, size: 24),
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Text("   Change Password",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontFamily: 'OpenSans')),
        ),
        SizedBox(height: 0, width: 50),
        Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 24),
      ]),
    );
  }
  @override
  void initState() {
    super.initState();
  }
}


