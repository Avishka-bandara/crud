import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'customer provider.dart';

class FindCustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Customer'),
        centerTitle: true,
      ),
      body: Consumer<CustomerProvider>(
        builder: (context, provider, child) {
          if (provider.customers.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: provider.customers.map((customer) {
                return ListTile(
                  title:
                      Text('${customer['firstName']} ${customer['lastName']}'),
                  subtitle: Text('Email: ${customer['email']}\n'
                      'Phone: ${customer['phone']}\n'
                      'Address: ${customer['address']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete Customer'),
                          content: Text(
                              'Are you sure you want to delete this customer?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );

                      if (confirm) {
                        await context
                            .read<CustomerProvider>()
                            .deleteCustomer(customer['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Customer deleted successfully'),
                          ),
                        );
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
