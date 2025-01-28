import 'package:flutter/material.dart';

import '../widgets/custom_text_input.dart';
import 'grid_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final TextEditingController rowsController = TextEditingController();
  final TextEditingController colsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup Grid'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter grid dimensions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CustomTextInput(
              label: 'Enter rows (m)',
              controller: rowsController,
              inputType: TextInputType.number,
            ),
            SizedBox(height: 16),
            CustomTextInput(
              label: 'Enter columns (n)',
              controller: colsController,
              inputType: TextInputType.number,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                final rows = int.tryParse(rowsController.text) ?? 0;
                final cols = int.tryParse(colsController.text) ?? 0;
                if (rows > 0 && cols > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GridScreen(rows: rows, cols: cols),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter valid numbers.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15), backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Create Grid',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
