import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/utilities/constants.dart';

class NotificationPage extends StatefulWidget {
  final AppUser user;
  const NotificationPage(this.user,{Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<AppUser> valueNotifier = ValueNotifier<AppUser>(widget.user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Bildirimler",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, value, widget) {
          return createBody(valueNotifier);
        },
      ),
    );
  }

  Widget createBody(ValueNotifier<AppUser> valueNotifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: widget.user.notifications.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, value, widget) {
              return NotificationCard(index,valueNotifier.value);
            },
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final int cardIndex;
  final AppUser user;
  const NotificationCard(this.cardIndex,this.user,{Key? key}) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: 100,
            width: 500,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: IntrinsicWidth(
                child: Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(widget.user.notifications[widget.cardIndex].desc)
                      ),
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              widget.user.notifications[widget.cardIndex].time
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ],
                      )
                    ]
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

