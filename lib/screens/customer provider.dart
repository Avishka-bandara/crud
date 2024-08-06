import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _customers = [];

  bool _isUpdateMode = false;
  String _currentCustomerId = '';

  List<Map<String, dynamic>> get customers => _customers;
  bool get isUpdateMode => _isUpdateMode;
  String get currentCustomerId => _currentCustomerId;

  Future<void> addCustomer(Map<String, dynamic> customerData) async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('customers').add(customerData);
    customerData['id'] = docRef.id;
    _customers.add(customerData);
    notifyListeners();
  }

  Future<void> updateCustomer(String id, Map<String, dynamic> customerData) async {
    await FirebaseFirestore.instance.collection('customers').doc(id).update(customerData);
    int index = _customers.indexWhere((customer) => customer['id'] == id);
    _customers[index] = {...customerData, 'id': id};
    notifyListeners();
  }

  Future<void> deleteCustomer(String id) async {
    await FirebaseFirestore.instance.collection('customers').doc(id).delete();
    _customers.removeWhere((customer) => customer['id'] == id);
    notifyListeners();
  }

  Future<void> fetchCustomers() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('customers').get();
    _customers.clear();
    for (var doc in querySnapshot.docs) {
      _customers.add(doc.data()..['id'] = doc.id);
    }
    notifyListeners();
  }

  void setUpdateMode(String id) {
    _isUpdateMode = true;
    _currentCustomerId = id;
    notifyListeners();
  }

  void clearUpdateMode() {
    _isUpdateMode = false;
    _currentCustomerId = '';
    notifyListeners();
  }
}
