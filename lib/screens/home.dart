import 'package:flutter/material.dart';
import 'add customer.dart';
import 'find customer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 30, 114, 194),
                  fixedSize: const Size(300, 45)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCustomerScreen()),
                );
              },
              child: Text(
                'Add Customer',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 30, 114, 194),
                  fixedSize: const Size(300, 45)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FindCustomerScreen()),
                );
              },
              child: Text('Find Customer',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ],
        )),
      ),
    );
  }
}
