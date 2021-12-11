import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';

class Campaigns extends StatefulWidget {
  final AppUser user;
  const Campaigns(this.user,{Key? key}) : super(key: key);

  @override
  _CampaignsState createState() => _CampaignsState();
}

class _CampaignsState extends State<Campaigns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        addAutomaticKeepAlives: true,
        children: [
          buildCampaignContainer(1),
          buildCampaignContainer(2),
          buildCampaignContainer(3),
          buildCampaignContainer(4),
          buildCampaignContainer(5),
        ],
      ),
    );
  }

  Container buildCampaignContainer(int numberOfCampaing) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.amber,
      ),
      width: 100,
      height: 200,
      child: Center(
        child: Text(
          "Campaign$numberOfCampaing",
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
