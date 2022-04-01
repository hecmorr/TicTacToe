part of 'tic_tac_toe_bloc.dart';

@immutable
abstract class TicTacToeEvent {}

class TicTacToeCellClicked extends TicTacToeEvent {
  TicTacToeCellClicked(this.cellIndex);

  final int cellIndex;
}

class TicTacToeRestarted extends TicTacToeEvent {}

class TicTacToeWinnerVerified extends TicTacToeEvent {}
