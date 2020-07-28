import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fractaltest/models/customer.dart';
import 'package:fractaltest/screens/home/add_edit_bsheet.dart';
import 'package:fractaltest/services/database_service.dart';

class CustomerCardWidget extends StatelessWidget {

  final Customer customer;
  CustomerCardWidget({this.customer});

  @override
  Widget build(BuildContext context) {


    void _showAlertDeleteDialog(BuildContext context) {

      Widget cancelButton = FlatButton(
        child: Text("Cancel"),
        onPressed:  () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = FlatButton(
        child: Text("Continue"),
        onPressed:  () async{
          try{
            Navigator.of(context).pop();
            await DatabaseService(uid: customer.uid).deleteCostumer();
          }catch(e){
            print(e.toString());
          }
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Warning"),
        content: Text("You are about deleting one item from the database, Do you want to continue?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Avatar
            Expanded(
              flex: 3,
              child: Card(
                elevation: 6.0,
                child: CircleAvatar(
                  radius: 36,
                  child: Center(
                    child: Text(
                      customer.firstName[0].toUpperCase() + customer.lastName[0].toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),
            ),
            //Content Data
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    customer.firstName + ' ' + customer.lastName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(customer.email),
                  Text('+51 '+ customer.phoneNumber.toString())
                ],
              ),
            ),
            //Edit Button
            Expanded(
              child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){

                    AddEditBottomSheet(
                      context: context,
                      customer: customer,
                      isAdd: false,
                    ).bottomSheetEdit();
                  }
              ),
            ),
            //Delete Button
            Expanded(
              child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _showAlertDeleteDialog(context);
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

