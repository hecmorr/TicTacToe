import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'tic_tac_toe_event.dart';
part 'tic_tac_toe_state.dart';

class TicTacToeBloc extends Bloc<TicTacToeEvent, TicTacToeState> {
  TicTacToeBloc() : super(const TicTacToeState()) {
    on<TicTacToeRestarted>(_onTicTacToeRestarted);
    on<TicTacToeCellClicked>(_onTicTacToeCellClicked);
    on<TicTacToeWinnerVerified>(_onTicTacToeWinnerVerified);
  }

  /// All possible winning combinations
  static const posibleSolutions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  /// X uses > 0 values and O uses < 0 values
  void _onTicTacToeCellClicked(
    TicTacToeCellClicked event,
    Emitter<TicTacToeState> emit,
  ) {
    final newList = [...state.board];

    final value = state.isXTurn ? 1 : -1;
    newList[event.cellIndex] = value;
    emit(
      TicTacToeState(isXTurn: !state.isXTurn, board: newList),
    );
    add(TicTacToeWinnerVerified());
  }

  void _onTicTacToeRestarted(
    TicTacToeRestarted event,
    Emitter<TicTacToeState> emit,
  ) {
    emit(const TicTacToeState());
  }

  void _onTicTacToeWinnerVerified(
    TicTacToeWinnerVerified event,
    Emitter<TicTacToeState> emit,
  ) {
    for (final posibleSolution in posibleSolutions) {
      var count = 0;
      for (final index in posibleSolution) {
        count += state.board[index];
      }

      if (count == 3 || count == -3) {
        emit(
          TicTacToeState(
            board: state.board,
            isXTurn: state.isXTurn,
            status: GameStatus.endGame,
          ),
        );

        return;
      }
    }

    /// If no 0 is found in the board means the board is full,
    /// and if no winner was previously found means it's a tie.
    final indexOfEmpty = state.board.indexOf(0);
    if (indexOfEmpty < 0) {
      emit(
        TicTacToeState(
          board: state.board,
          isXTurn: state.isXTurn,
          status: GameStatus.tie,
        ),
      );
    }
  }
}
