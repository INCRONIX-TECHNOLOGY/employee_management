import 'package:flutter/material.dart';

class PayrollPageReciept extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payroll/पगार'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Color.fromRGBO(170, 68, 101, 1.0),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'ABC Corporation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Abc Nagar, Abc Road, NearAbc Bakery, Abc(East), Tal-\nAbc, Dist-Abc',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Receipt',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(170, 68, 101, 1.0),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Receipt No: X1'),
                      Text('Employee ID: W12345'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Employee Name: XYZ'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRow('No. of Days Present:', '24'),
                        _buildRow('No. of Days Absent:', '5'),
                        _buildRow('Basic Salary:', '100,000'),
                        _buildRow('Overtime:', '2,000'),
                        _buildRow('Advance Payment:', '1,000'),
                        _buildRow('Advance RePayment:', '1,000'),
                        _buildRow('Debit Note Payment:', '1,000'),
                        _buildRow('Debit Note RePayment:', '1,000'),
                        _buildRow('PF:', '1,000'),
                        Divider(),
                        _buildRow(
                          'Net Salary:',
                          '97,000',
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Digital Signature',
                      style: TextStyle(decoration: TextDecoration.underline,color:  Color.fromRGBO(170, 68, 101, 1.0),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Logic to print the receipt
            print('Print receipt');
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromRGBO(170, 68, 101, 1),

            padding: EdgeInsets.symmetric(vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
          child: Text('Print Receipt'),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: fontWeight),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }
}


