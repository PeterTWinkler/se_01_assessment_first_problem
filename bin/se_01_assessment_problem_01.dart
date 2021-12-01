void main(List<String> arguments) {
  /// The input formatted as a matrix.
  final inputMatrix = [
    ['.', '.', '*'],
    ['.', '.', '.'],
    ['.', '*', '.'],
  ];

  /// This matrix will be modified to give the desired input.
  /// The items are dynamic, so that '*' Strings marking the mines can
  /// overwrite the integer values.
  List<List<dynamic>> outputMatrix = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
  ];

  /// Takes the coordinates of a field, marks field as a mine,
  /// then adds 1 to the value of all existing neighbouring fields
  /// in the output matrix.
  void add1ToNeighbors(int i, int j) {

    /// Marks the location of the mine in the output matrix.
    outputMatrix[i][j] = '*';

    /// Iterates through the 3x3 field that has the argument coordinates
    /// in the middle.
    for (var k = -1; k < 2; k++) {
      for (var l = -1; l < 2; l++) {
        /// Checks if the coordinates point to an existing field,
        /// and if it is of type integer.
        /// Skips the middle field, because it is now a String.
        if ([0,1,2].contains(i+k) && [0,1,2].contains(j+l)) {
          if (outputMatrix[i+k][j+l] is int) {
            outputMatrix[i+k][j+l]++;
          }
        }
      }
    }
  }

  List mineSweeper(inputMatrix) {
    /// Iterates through input matrix to find mines and modifies
    /// the output matrix accordingly.
    for (var i = 0; i < 3; i++) {
      for(var j = 0; j < 3; j++) {
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

  /// Calls the mineSweeper function to get the output.
  var output = mineSweeper(inputMatrix);

  /// Prints output to the console.
  printMatrixToConsole(output);
}