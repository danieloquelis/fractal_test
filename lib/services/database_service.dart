import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fractaltest/models/customer.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference customerCollection = Firestore.instance.collection('customer');

  Future updateCostumerData (String firstName, String lastName, String email, int phoneNumber ) async {
    return await customerCollection.document(uid).setData({
      'firstName': firstName,
      'lastName' : lastName,
      'email'    : email,
      'phone'    : phoneNumber,
    });
  }

  Future deleteCostumer() async{
    return await customerCollection.document(uid).delete();
  }

  Future addNewCustomer (String firstName, String lastName, String email, int phoneNumber ) async {
    return await customerCollection.document().setData({
      'firstName': firstName,
      'lastName' : lastName,
      'email'    : email,
      'phone'    : phoneNumber,
    });
  }

  List<Customer> _customerListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Customer(
        uid: doc.documentID,
        firstName: doc.data['firstName'] ?? 'New First Name',
        lastName: doc.data['lastName'] ?? 'New Last Name',
        email: doc.data['email'] ?? 'example@blaze.com',
        phoneNumber: doc.data['phone'] ?? 111222333,
      );
    }).toList();
  }

  Stream<List<Customer>> get customers {
    return customerCollection.snapshots().map(_customerListFromSnapshot);
  }

  //Any Query to Test
  Future<QuerySnapshot> queryData (String value) async{
    return await customerCollection
        .where('firstName', isEqualTo: value)
        .getDocuments();

  }
}
