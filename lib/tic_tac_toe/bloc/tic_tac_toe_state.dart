part of 'tic_tac_toe_bloc.dart';

/// Possible status
enum GameStatus {
  playing,
  endGame,
  tie,
}

@immutable
class TicTacToeState extends Equatable {
  const TicTacToeState({
    this.status = GameStatus.playing,
    this.isXTurn = true,
    this.board = const [0, 0, 0, 0, 0, 0, 0, 0, 0],
  });

  final GameStatus status;
  final bool isXTurn;
  final List<int> board;

  @override
  List<Object?> get props => [board, isXTurn, status];
}
