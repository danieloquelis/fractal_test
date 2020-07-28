import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fractaltest/models/customer.dart';
import 'package:fractaltest/screens/home/customer_card_widget.dart';
import 'package:fractaltest/services/database_service.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Customer> dataQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: TextField(
          cursorColor: Colors.white,
          onChanged: (val){
            DatabaseService().queryData(val).then((QuerySnapshot snapshot) {
              if(snapshot.documents.isNotEmpty){
                setState(() {
                  dataQuery = snapshot.documents.map((doc) {
                    return Customer(
                      uid: doc.documentID,
                      firstName: doc.data['firstName'] ,
                      lastName: doc.data['lastName'] ,
                      email: doc.data['email'] ,
                      phoneNumber: doc.data['phone'] ,
                    );
                  }).toList();
                });
              }
            });
          },
          decoration: InputDecoration(
              hintText: 'Search by Names',
              prefixIcon: Icon(Icons.search)
          ),

        ),
      ),
      body:  dataQuery!=null ? ListView.builder(
        itemCount: dataQuery.length,
        itemBuilder: (context, index) {
          return CustomerCardWidget(customer: dataQuery[index]);
        },
      ) : Center(child: Text('No Results'))
    );
  }
}
