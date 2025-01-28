import 'package:flutter/material.dart';
import '../widgets/grid_display.dart';
import 'reset_handler.dart';

class GridScreen extends StatefulWidget {
  final int rows;
  final int cols;

  GridScreen({required this.rows, required this.cols});

  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  List<List<String>> grid = [];
  final TextEditingController inputController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  String searchText = '';
  int currentIndex = 0;
  bool gridPopulated = false;

  @override
  void initState() {
    super.initState();
    grid = List.generate(widget.rows, (_) => List.filled(widget.cols, ''));
  }

  void populateGrid(String input) {
    if (input.length != 1 || !RegExp(r'^[a-zA-Z]$').hasMatch(input)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a single alphabet.')),
      );
      return;
    }
    final row = currentIndex ~/ widget.cols;
    final col = currentIndex % widget.cols;
    setState(() {
      grid[row][col] = input.toUpperCase();
      currentIndex++;
      if (currentIndex == widget.rows * widget.cols) {
        gridPopulated = true;
      }
    });
    inputController.clear();
  }

  void highlightSearchText(String text) {
    setState(() {
      searchText = text.toLowerCase();
    });
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ResetHandler.resetApp(context, '/setup');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!gridPopulated)
              Column(
                children: [
                  Text(
                    'Position: Row ${currentIndex ~/ widget.cols + 1}, Column ${currentIndex % widget.cols + 1}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    controller: inputController,
                    decoration: InputDecoration(
                      hintText: 'Enter a single alphabet',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    onSubmitted: populateGrid,
                  ),
                ],
              ),
            if (gridPopulated)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: GridDisplay(
                        grid: grid,
                        searchText: searchText,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Enter text to search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      onSubmitted: highlightSearchText,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
