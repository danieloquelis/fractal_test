import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fractaltest/models/customer.dart';
import 'package:fractaltest/screens/home/add_edit_bsheet.dart';
import 'package:fractaltest/screens/search/search.dart';
import 'package:fractaltest/services/database_service.dart';
import 'package:provider/provider.dart';

import 'customer_cards.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Creating Data for Testing
  void generateCustomers()async{
    //I had 5 customers already
    for(int i = 1; i<=95; i++){
      await DatabaseService().addNewCustomer('Name ${i.toString()}', 'lastName ${i.toString()}' , '${i.toString()}@gmail.com', 999990 + i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Customer>>.value(
      value: DatabaseService().customers,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Customer List'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                Navigator.pushNamed(context, '/search');
              },
            ),
            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () async{
                try{
                  //generateCustomers();
                  AddEditBottomSheet(
                    context: context,
                    isAdd: true,
                  ).bottomSheetEdit();

                }catch(e){
                  print(e.toString());
                }
              },
            ),
          ],
        ),
        body: CustomerCards(),
      ),
    );
  }
}
