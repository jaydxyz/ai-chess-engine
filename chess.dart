import 'dart:io';
import 'dart:math';

const int SIZE = 8;
const String PIECES = "RNBQKBNRPPPPPPPP                                pppppppprnbqkbnr";
const List<int> PAWN_OFFSETS = [16, 32, 17, 15, -16, -32, -17, -15];
const List<int> KNIGHT_OFFSETS = [33, 31, 18, 14, -33, -31, -18, -14];
const List<int> BISHOP_OFFSETS = [15, 17, -15, -17];
const List<int> ROOK_OFFSETS = [1, 16, -1, -16];
const List<int> QUEEN_OFFSETS = [1, 16, -1, -16, 15, 17, -15, -17];
const List<int> KING_OFFSETS = [1, 16, -1, -16, 15, 17, -15, -17];

int evaluateBoard(String board) {
  int score = 0;
  for (int i = 0; i < SIZE * SIZE; i++) {
    int piece = board.codeUnitAt(i);
    if (piece >= 97 && piece <= 122) {
      score -= getPieceValue(piece);
    } else if (piece >= 65 && piece <= 90) {
      score += getPieceValue(piece);
    }
  }
  return score;
}

int getPieceValue(int piece) {
  switch (piece) {
    case 'P'.codeUnits[0]:
    case 'p'.codeUnits[0]:
      return 100;
    case 'N'.codeUnits[0]:
    case 'n'.codeUnits[0]:
    case 'B'.codeUnits[0]:
    case 'b'.codeUnits[0]:
      return 300;
    case 'R'.codeUnits[0]:
    case 'r'.codeUnits[0]:
      return 500;
    case 'Q'.codeUnits[0]:
    case 'q'.codeUnits[0]:
      return 900;
    case 'K'.codeUnits[0]:
    case 'k'.codeUnits[0]:
      return 10000;
    default:
      return 0;
  }
}

List<String> generateMoves(String board, bool whiteToMove) {
  List<String> moves = [];
  for (int i = 0; i < SIZE * SIZE; i++) {
    int piece = board.codeUnitAt(i);
    if ((whiteToMove && piece >= 65 && piece <= 90) ||
        (!whiteToMove && piece >= 97 && piece <= 122)) {
      switch (piece) {
        case 'P'.codeUnits[0]:
        case 'p'.codeUnits[0]:
          addPawnMoves(board, i, moves, whiteToMove);
          break;
        case 'N'.codeUnits[0]:
        case 'n'.codeUnits[0]:
          addKnightMoves(board, i, moves, whiteToMove);
          break;
        case 'B'.codeUnits[0]:
        case 'b'.codeUnits[0]:
          addBishopMoves(board, i, moves, whiteToMove);
          break;
        case 'R'.codeUnits[0]:
        case 'r'.codeUnits[0]:
          addRookMoves(board, i, moves, whiteToMove);
          break;
        case 'Q'.codeUnits[0]:
        case 'q'.codeUnits[0]:
          addQueenMoves(board, i, moves, whiteToMove);
          break;
        case 'K'.codeUnits[0]:
        case 'k'.codeUnits[0]:
          addKingMoves(board, i, moves, whiteToMove);
          break;
      }
    }
  }
  return moves;
}

void addPawnMoves(String board, int start, List<String> moves, bool white) {
  for (int offset in PAWN_OFFSETS) {
    int dest = start + offset;
    if (dest >= 0 && dest < SIZE * SIZE) {
      int piece = board.codeUnitAt(dest);
      if (piece == 32) {
        if ((white && offset == 16) || (!white && offset == -16)) {
          moves.add(indexToNotation(start) + indexToNotation(dest));
        }
        if ((white && start >= 48 && start <= 55 && offset == 32) ||
            (!white && start >= 8 && start <= 15 && offset == -32)) {
          moves.add(indexToNotation(start) + indexToNotation(dest));
        }
      } else if ((white && piece >= 97 && piece <= 122) ||
          (!white && piece >= 65 && piece <= 90)) {
        if ((white && (offset == 15 || offset == 17)) ||
            (!white && (offset == -15 || offset == -17))) {
          moves.add(indexToNotation(start) + "x" + indexToNotation(dest));
        }
      }
    }
  }
}

void addKnightMoves(String board, int start, List<String> moves, bool white) {
  for (int offset in KNIGHT_OFFSETS) {
    int dest = start + offset;
    if (dest >= 0 && dest < SIZE * SIZE) {
      int piece = board.codeUnitAt(dest);
      if (piece == 32 ||
          (white && piece >= 97 && piece <= 122) ||
          (!white && piece >= 65 && piece <= 90)) {
        moves.add(indexToNotation(start) +
            (piece == 32 ? "" : "x") +
            indexToNotation(dest));
      }
    }
  }
}

void addBishopMoves(String board, int start, List<String> moves, bool white) {
  for (int offset in BISHOP_OFFSETS) {
    for (int i = 1;; i++) {
      int dest = start + offset * i;
      if (dest < 0 || dest >= SIZE * SIZE) break;
      int piece = board.codeUnitAt(dest);
      if (piece == 32) {
        moves.add(indexToNotation(start) + indexToNotation(dest));
      } else if ((white && piece >= 97 && piece <= 122) ||
          (!white && piece >= 65 && piece <= 90)) {
        moves.add(indexToNotation(start) + "x" + indexToNotation(dest));
        break;
      } else {
        break;
      }
    }
  }
}

void addRookMoves(String board, int start, List<String> moves, bool white) {
  for (int offset in ROOK_OFFSETS) {
    for (int i = 1;; i++) {
      int dest = start + offset * i;
      if (dest < 0 || dest >= SIZE * SIZE) break;
      int piece = board.codeUnitAt(dest);
      if (piece == 32) {
        moves.add(indexToNotation(start) + indexToNotation(dest));
      } else if ((white && piece >= 97 && piece <= 122) ||
          (!white && piece >= 65 && piece <= 90)) {
        moves.add(indexToNotation(start) + "x" + indexToNotation(dest));
        break;
      } else {
        break;
      }
    }
  }
}

void addQueenMoves(String board, int start, List<String> moves, bool white) {
  addBishopMoves(board, start, moves, white);
  addRookMoves(board, start, moves, white);
}

void addKingMoves(String board, int start, List<String> moves, bool white) {
  for (int offset in KING_OFFSETS) {
    int dest = start + offset;
    if (dest >= 0 && dest < SIZE * SIZE) {
      int piece = board.codeUnitAt(dest);
      if (piece == 32 ||
          (white && piece >= 97 && piece <= 122) ||
          (!white && piece >= 65 && piece <= 90)) {
        moves.add(indexToNotation(start) +
            (piece == 32 ? "" : "x") +
            indexToNotation(dest));
      }
    }
  }
}

String indexToNotation(int index) {
  int file = index % 8;
  int rank = index ~/ 8;
  return String.fromCharCode(file + 97) + (rank + 1).toString();
}

String makeMove(String board, String move) {
  int start = notationToIndex(move.substring(0, 2));
  int dest = notationToIndex(move.substring(2, 4));
  return board.substring(0, start) +
      ' ' +
      board.substring(start + 1, dest) +
      board[start] +
      board.substring(dest + 1);
}

int notationToIndex(String notation) {
  int file = notation.codeUnitAt(0) - 97;
  int rank = int.parse(notation[1]) - 1;
  return rank * 8 + file;
}

int minimax(String board, int depth, int alpha, int beta, bool maximizingPlayer) {
  if (depth == 0) {
    return evaluateBoard(board);
  }
  List<String> moves = generateMoves(board, maximizingPlayer);
  if (maximizingPlayer) {
    int maxEval = -999999;
    for (String move in moves) {
      String newBoard = makeMove(board, move);
      int eval = minimax(newBoard, depth - 1, alpha, beta, false);
      maxEval = max(maxEval, eval);
      alpha = max(alpha, eval);
      if (beta <= alpha) {
        break;
      }
    }
    return maxEval;
  } else {
    int minEval = 999999;
    for (String move in moves) {
      String newBoard = makeMove(board, move);
      int eval = minimax(newBoard, depth - 1, alpha, beta, true);
      minEval = min(minEval, eval);
      beta = min(beta, eval);
      if (beta <= alpha) {
        break;
      }
    }
    return minEval;
  }
}

String findBestMove(String board, int depth) {
  List<String> moves = generateMoves(board, true);
  int bestScore = -999999;
  String bestMove = "";
  for (String move in moves) {
    String newBoard = makeMove(board, move);
    int score = minimax(newBoard, depth - 1, -999999, 999999, false);
    if (score > bestScore) {
      bestScore = score;
      bestMove = move;
    }
  }
  return bestMove;
}

void main() {
  String board = PIECES;
  bool whiteToMove = true;
  while (true) {
    stdout.write(whiteToMove ? "\nWhite's move: " : "\nBlack's move: ");
    String move = stdin.readLineSync()!;
    if (move == 'quit') break;
    if (move == '') {
      move = findBestMove(board, 3);
      print("Computer's move: $move");
    }
    board = makeMove(board, move);
    whiteToMove = !whiteToMove;
  }
}
