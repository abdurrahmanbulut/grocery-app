import 'package:flutter/material.dart';
import 'package:grocery_app/model/user.dart';

class OrderScreen extends StatefulWidget {
  Order order;
  OrderScreen({required this.order}) : super();

  final String title = "Stepper Demo";

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  //
  int current_step = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.order.status == OrderStatus.waiting)
      current_step = 0;
    else if (widget.order.status == OrderStatus.prepared)
      current_step = 1;
    else if (widget.order.status == OrderStatus.taken) current_step = 2;
    print(current_step);
    print(widget.order.status);
    print(widget.order.id);
    return Scaffold(
        // Appbar
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber,
          title: const Text('GROCERY APP',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'YOUR_FONT_FAMILY')),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        // Body
        body: Container(
            child: Stepper(
          steps: getSteps(),
          type: StepperType.vertical,
          currentStep: current_step,
        )));
  }

  List<Step> getSteps() => [
        Step(
          state: current_step > 0 ? StepState.complete : StepState.indexed,
          title: Text('Waiting for order aprove'),
          content: Container(
            child: Image(
              image: AssetImage("assets/images/order_confirm.jpg"),
            ),
          ),
          isActive: current_step >= 0,
        ),
        Step(
          state: current_step > 1 ? StepState.complete : StepState.indexed,
          title: Text('Order is being prepared'),
          content: Container(
            child: Image(
              image: AssetImage("assets/images/order_package.jpg"),
            ),
          ),
          isActive: current_step >= 1,
        ),
        Step(
          title: Text('Order is ready to pick up!'),
          content: Container(
            child: Image(
              image: AssetImage("assets/images/package_ready.png"),
            ),
          ),
          state: current_step > 2 ? StepState.complete : StepState.indexed,
          isActive: current_step >= 2,
        ),
      ];
}
