void main(List<String> arguments) {
  mineSweeper();
}

void mineSweeper() {
  /// The input formatted as a matrix.
  final inputMatrix3x3 = [
    ['.', '.', '*'],
    ['.', '.', '.'],
    ['.', '*', '.'],
  ];

  final inputMatrix4x4 = [
    ['.', '.', '*', '.'],
    ['.', '.', '.', '*'],
    ['.', '*', '.', '.'],
    ['.', '*', '.', '.'],
  ];

  /// These variables get assigned values by the countRowsAndColumns() function.
  /// They store how many columns and how many rows the playing field has.
  int rowsCount;
  int columnsCount;

  /// This matrix will be modified to give the desired input.
  /// The items are dynamic, so that '*' Strings marking the mines can
  /// overwrite the integer values.
  List<List<dynamic>> outputMatrix;

  List<List<dynamic>> playingField;

  /// Counts the number of rows and columns of the matrix. Assumes that
  /// all rows have the same number of columns.
  void countRowsAndColumns(List<List> inputMatrix) {
    rowsCount = inputMatrix.length;
    columnsCount = inputMatrix[0].length;
  }

  /// Generates the output matrix based on the number of rows and columns given.
  /// Fills it up with the value passed to the 'filler' argument.
  void generateSizedMatrixOf(rowsCount, columnsCount, filler) {
    outputMatrix = List.empty(growable: true);
    for (var i = 0; i < rowsCount; i++) {
      outputMatrix.add(List.filled(columnsCount, filler));
    }
  }

  /// Generates the playing field matrix based on the number of rows and
  /// columns given.
  /// Fills it up with the value passed to the 'filler' argument.
  void generateBlankPlayingField(rowsCount, columnsCount, filler) {
    playingField = List.empty(growable: true);
    for (var i = 0; i < rowsCount; i++) {
      playingField.add(List.filled(columnsCount, filler));
    }
  }

  /// Takes the coordinates of a field, marks field as a mine,
  /// then adds 1 to the value of all existing neighbouring fields
  /// in the output matrix.
  void add1ToNeighbors(int i, int j) {
    /// Marks the location of the mine in the output matrix.
    outputMatrix[i][j] = '*';

    /// Iterates through the 3x3 area that has the argument coordinates
    /// in the middle. This area contains all the neighbouring fields.
    for (var k = -1; k < 2; k++) {
      for (var l = -1; l < 2; l++) {
        /// Checks if the coordinates point to an existing field,
        /// and if it is of type integer.
        /// Skips the middle field, because it is now a String.
        if ((i + k >= 0 && i + k < rowsCount) &&
            (j + l >= 0 && j + l < columnsCount)) {
          if (outputMatrix[i + k][j + l] is int) {
            outputMatrix[i + k][j + l]++;
          }
        }
      }
    }
  }

  List generateMinefieldData(inputMatrix) {
    /// Counts the rows and columns of the input matrix and
    /// writes them in the global rowsCount and columnsCount variables.
    countRowsAndColumns(inputMatrix);

    generateSizedMatrixOf(rowsCount, columnsCount, 0);

    /// Iterates through input matrix to find mines and modifies
    /// the output matrix accordingly.
    for (var i = 0; i < rowsCount; i++) {
      for (var j = 0; j < columnsCount; j++) {
        if (inputMatrix[i][j] == '*') {
          add1ToNeighbors(i, j);
        }
      }
    }
    return outputMatrix;
  }

  /// Takes a matrix and prints it line-by-line to the console.
  void printMatrixToConsole(matrix) {
    for (var row in matrix) {
      var line = '';
      for (var item in row) {
        line = line + item.toString();
      }
      print(line);
    }
  }

  void gameLoop() {
    bool isGameOn = true;

    while (isGameOn) {
      print(playingField);
      printMatrixToConsole(playingField);
    }
  }


  /// Calls the generateMinefieldData function to get the minefield information
  /// that the player needs to uncover.
  var minefieldData = generateMinefieldData(inputMatrix4x4);

  /// Prints output to the console.
  //printMatrixToConsole(minefieldData);

  generateBlankPlayingField(rowsCount, columnsCount, '-');

  gameLoop();
}
