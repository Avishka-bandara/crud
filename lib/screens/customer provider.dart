import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CustomerProvider with ChangeNotifier {
  final CollectionReference _customersCollection =
      FirebaseFirestore.instance.collection('customers');

  List<Map<String, dynamic>> _customers = [];

  List<Map<String, dynamic>> get customers => _customers;

  CustomerProvider() {
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    final snapshot = await _customersCollection.get();
    _customers = snapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
        .toList();
    notifyListeners();
  }

  Future<void> addCustomer(Map<String, dynamic> customerData) async {
    await _customersCollection.add(customerData);
    fetchCustomers();
  }

  Future<void> deleteCustomer(String id) async {
    await _customersCollection.doc(id).delete();
    fetchCustomers();
  }
}
