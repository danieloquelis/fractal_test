import 'package:flutter/material.dart';
import 'package:fractaltest/models/customer.dart';
import 'package:fractaltest/services/database_service.dart';
import 'package:fractaltest/utils/decorations.dart';

class AddEditBottomSheet{
  String firstName ='';
  String lastName ='';
  String email='';
  int phoneNumber;
  Customer customer;
  BuildContext context;
  bool isAdd;

  AddEditBottomSheet({this.customer,this.context,this.isAdd});

  final _formKey = GlobalKey<FormState>();

  Future bottomSheetEdit() async{
    //set the first values
    if (!isAdd){
      firstName = customer.firstName;
      lastName = customer.lastName;
      email = customer.email;
      phoneNumber = phoneNumber;
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder){
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0))),
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //Title
                        Padding(
                          padding: const EdgeInsets.only(top: 36.0, bottom: 24.0),
                          child: Text(
                            isAdd ? 'Add New User' :'Edit Costumer',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                color: Colors.teal[800]
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        //Text Fields
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 42, vertical: 12),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                    controller: TextEditingController(text: isAdd ? '' : customer.firstName),
                                    validator: (val)=> val.isEmpty? 'Fill this field':null,
                                    onChanged: (val){
                                      firstName = val;
                                    },
                                    textAlign: TextAlign.start,
                                    decoration: formDecoration.copyWith(
                                        labelText: 'First Name',
                                        icon: Icon(Icons.group)
                                    )
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                    controller: TextEditingController(text: isAdd ? '' :customer.lastName),
                                    validator: (val)=> val.isEmpty? 'Fill this field':null,
                                    onChanged: (val){
                                      lastName = val;
                                    },
                                    textAlign: TextAlign.start,
                                    decoration: formDecoration.copyWith(
                                        labelText: 'Last Name',
                                        icon: Icon(Icons.account_circle)
                                    )
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                    controller: TextEditingController(text: isAdd ? '' :customer.email),
                                    validator: (val)=> val.isEmpty? 'Fill this field':null,
                                    onChanged: (val){
                                      email = val;
                                    },
                                    textAlign: TextAlign.start,
                                    decoration: formDecoration.copyWith(
                                        labelText: 'E-mail',
                                        icon: Icon(Icons.email)
                                    )
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                    controller: TextEditingController(text: isAdd ? '' : customer.phoneNumber.toString()),
                                    validator: (val)=> val.isEmpty? 'Fill this field':null,
                                    onChanged: (val){
                                      phoneNumber = int.parse(val);
                                    },
                                    keyboardType: TextInputType.phone,
                                    textAlign: TextAlign.start,
                                    decoration: formDecoration.copyWith(
                                        labelText: 'Phone Number',
                                        icon: Icon(Icons.phone_android)
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 42),
                        //Buttons
                        Padding(
                          padding: EdgeInsets.only(bottom: 54.0),
                          child: Row(
                            children: <Widget>[
                              //Cancel
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 24),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(24))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //Update
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: ()async{
                                    if (_formKey.currentState.validate()) {
                                      if (isAdd){
                                        await DatabaseService().addNewCustomer(firstName, lastName , email, phoneNumber);
                                        Navigator.of(context).pop();
                                      }else{
                                        await DatabaseService(uid: customer.uid).updateCostumerData(firstName, lastName, email, phoneNumber);
                                        Navigator.of(context).pop();
                                      }
                                    }
                                    //
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 24,left: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.teal[800],
                                        borderRadius: BorderRadius.all(Radius.circular(24)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.8),
                                              blurRadius: 8,
                                              offset: Offset(0, 6)
                                          )
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: Text(
                                          isAdd ? 'Add New' : 'Update',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        }
    );
  }

}

