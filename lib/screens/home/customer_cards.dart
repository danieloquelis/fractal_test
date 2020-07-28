import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fractaltest/models/customer.dart';
import 'package:fractaltest/screens/home/customer_card_widget.dart';
import 'package:provider/provider.dart';

class CustomerCards extends StatefulWidget {


  @override
  _CustomerCardsState createState() => _CustomerCardsState();
}

class _CustomerCardsState extends State<CustomerCards> {
  @override
  Widget build(BuildContext context) {

    final customer = Provider.of<List<Customer>>(context);

    if (customer!= null){
      return ListView.builder(
        itemCount: customer.length,
        itemBuilder: (context, index) {
          return CustomerCardWidget(customer: customer[index]);
        },
      );
    }else{
      return SpinKitFadingCircle(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.teal : Colors.teal,
            ),
          );
        },
      );
    }
  }
}
