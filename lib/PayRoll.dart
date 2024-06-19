import 'dart:ffi';

import 'package:flutter/material.dart';

class PayrollPage extends StatelessWidget {
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
            PayrollCard(
              month: 'January',
              daysPresent: 24,
              daysAbsent: 5,
              advancePayment: 1000,
              totalPayroll: 97000,
              basicSalary: 100000,
              deductions: 5000,
              overtime: 2000,
              netSalary: 97000,
            ),
            PayrollCard(
              month: 'February',
              daysPresent: 0,
              daysAbsent: 0,
              advancePayment: 0,
              totalPayroll: 0,
              basicSalary: 0,
              deductions: 0,
              overtime: 0,
              netSalary: 0,
            ),
            PayrollCard(
              month: 'March',
              daysPresent: 0,
              daysAbsent: 0,
              advancePayment: 0,
              totalPayroll: 0,
              basicSalary: 0,
              deductions: 0,
              overtime: 0,
              netSalary: 0,
            ),
            PayrollCard(
              month: 'April',
              daysPresent: 0,
              daysAbsent: 0,
              advancePayment: 0,
              totalPayroll: 0,
              basicSalary: 0,
              deductions: 0,
              overtime: 0,
              netSalary: 0,
            ),
            PayrollCard(
              month: 'May',
              daysPresent: 0,
              daysAbsent: 0,
              advancePayment: 0,
              totalPayroll: 0,
              basicSalary: 0,
              deductions: 0,
              overtime: 0,
              netSalary: 0,
            ),
          ],
        ),
      ),
    );
  }
}

class PayrollCard extends StatefulWidget {
  final String month;
  final int daysPresent;
  final int daysAbsent;
  final int advancePayment;
  final int totalPayroll;
  final int basicSalary;
  final int deductions;
  final int overtime;
  final int netSalary;

  PayrollCard({
    required this.month,
    required this.daysPresent,
    required this.daysAbsent,
    required this.advancePayment,
    required this.totalPayroll,
    required this.basicSalary,
    required this.deductions,
    required this.overtime,
    required this.netSalary,
  });

  @override
  _PayrollCardState createState() => _PayrollCardState();
}

class _PayrollCardState extends State<PayrollCard> {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  void _printReceipt() {
    // Logic to print the receipt
    print('Print receipt for ${widget.month}');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.month, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: _toggleExpanded,
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('No. of Days Present: ${widget.daysPresent}'),
                      Icon(Icons.print, color: Colors.blue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('No. of Days Absent: ${widget.daysAbsent}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Basic Salay:  ${widget.advancePayment}/-',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 90),

                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Over Time: ${widget.advancePayment}/-',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width:  85),
                    ],
                  ),


                  Row(
                    children: [
                      Text(
                        'Advance Repayment: ${widget.advancePayment}/-',
                        style: TextStyle(color: Colors.red),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Debeit Note Repayment: ${widget.advancePayment}/-',
                        style: TextStyle(color: Colors.red),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'PF: ${widget.advancePayment}/-',
                        style: TextStyle(color: Colors.black),
                      ),

                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Total Payroll:${widget.totalPayroll}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Net Salary',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.netSalary.toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
