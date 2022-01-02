import 'package:flutter/material.dart';
import 'package:grocery_app/model/data_model.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/campaign/campaign_class.dart';
import 'dart:developer';

class Campaigns extends StatefulWidget {
  final AppUser user;
  final List<CategoryProduct> categories;
  const Campaigns(this.user, this.categories, {Key? key}) : super(key: key);

  @override
  _CampaignsState createState() => _CampaignsState();
}

class _CampaignsState extends State<Campaigns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: ListView(
        scrollDirection: Axis.vertical,
        addAutomaticKeepAlives: true,
        children: [
          buildCampaignContainer(0),
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
          color: Colors.white,
        ),
        child: Container(
          color: Colors.amberAccent,
          child: 
            TextButton.icon(
              icon: Image.asset(
                campaigns[numberOfCampaing].image,
                height: 250,
                width: 250,
              ),
              label: Column(
                children: const[
                  Text(
                    "\nClick here for details",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SecondRoute(data: numberOfCampaing)),
                );
              },
            ),
          
        ));
  }
}

class SecondRoute extends StatefulWidget {
  final int data;
  SecondRoute({required this.data});

  @override
  State<SecondRoute> createState() => _SecondRouteState(data: data);
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  final int data;
  _SecondRouteState({required this.data});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Campaign",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: printingCampaign(data));
  }
}

Container printingCampaign(int numberOfCampaing) {
  return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Center(child: Image.asset(campaigns[numberOfCampaing].image,width: 300,height: 300,)),
          Text(campaigns[numberOfCampaing].title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          Text(
            campaigns[numberOfCampaing].description,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ));
}
