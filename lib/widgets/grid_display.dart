import 'package:flutter/material.dart';

class GridDisplay extends StatelessWidget {
  final List<List<String>> grid;
  final String searchText;

  GridDisplay({required this.grid, required this.searchText});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: grid[0].length,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: grid.length * grid[0].length,
      itemBuilder: (context, index) {
        int row = index ~/ grid[0].length;
        int col = index % grid[0].length;

        bool isHighlighted = isPartOfSearchResult(row, col);

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isHighlighted ? Colors.yellow.shade200 : Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            grid[row][col],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isHighlighted ? Colors.black : Colors.blueAccent,
            ),
          ),
        );
      },
    );
  }

  bool isPartOfSearchResult(int row, int col) {
    if (searchText.isEmpty) return false;

    List<List<int>> directions = [
      [0, 1],
      [1, 0],
      [1, 1],
    ];

    for (var dir in directions) {
      int r = row, c = col;
      bool matches = true;

      for (int i = 0; i < searchText.length; i++) {
        if (r >= grid.length || c >= grid[0].length || grid[r][c].toLowerCase() != searchText[i]) {
          matches = false;
          break;
        }
        r += dir[0];
        c += dir[1];
      }

      if (matches) return true;
    }

    return false;
  }
}
