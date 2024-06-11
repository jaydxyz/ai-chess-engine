# Dart Chess Engine

This is a lightweight chess engine implemented in Dart. It includes basic chess rules, an AI opponent, efficient move generation, and a simple console interface.

## Features

1. **Chess Logic**: Implements the basic rules of chess, including piece moves. (Note: Special moves like castling, pawn promotion, and en passant are not included in this version for simplicity.)

2. **AI Opponent**: Utilizes the Minimax algorithm with alpha-beta pruning to create a challenging AI opponent. The AI evaluates the board based on piece values and decides the best move based on the current position.

3. **Efficient Move Generation**: Generates possible moves for any given board state based on the rules of chess.

4. **Console Interface**: Provides a simple text-based interface where moves can be input using standard chess notation (e.g., e2e4).

## Requirements

- Dart SDK (version 2.0 or higher)

## How to Run

1. Make sure you have Dart installed on your system. If not, you can download it from the official Dart website: [https://dart.dev/get-dart](https://dart.dev/get-dart)

2. Clone this repository or download the `chess.dart` file.

3. Open a terminal or command prompt and navigate to the directory where the `chess.dart` file is located.

4. Run the following command to start the chess engine:

   ```
   dart chess.dart
   ```

5. The chess engine will display the console interface, and you can start playing against the AI opponent.

## How to Play

- The game starts with White's move. Enter your move using standard chess notation (e.g., e2e4, d7d5).

- To let the AI make a move, simply press Enter without entering a move.

- The game will continue alternating between White's move and Black's move until the game ends or you choose to quit.

- To quit the game at any point, enter 'quit'.

## Limitations

- The chess engine does not include special moves like castling, pawn promotion, and en passant.

- The AI opponent uses a basic implementation of the Minimax algorithm with alpha-beta pruning. It may not be as strong as more advanced chess engines.

- The console interface is text-based and does not provide a graphical representation of the chessboard.

## Future Enhancements

- Implement special moves like castling, pawn promotion, and en passant.

- Improve the AI opponent by using more advanced algorithms and heuristics.

- Add a graphical user interface (GUI) to enhance the user experience.

- Implement chess game notations and the ability to save and load games.

## Acknowledgements

This chess engine was developed as a learning project and is inspired by various chess programming resources and tutorials available online.

## License

This project is open-source and available under the [MIT License](LICENSE).

Feel free to contribute, provide feedback, or report any issues you encounter while using this chess engine.

Enjoy playing chess with the Dart Chess Engine!
