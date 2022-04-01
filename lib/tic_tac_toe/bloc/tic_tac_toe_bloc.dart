import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'tic_tac_toe_event.dart';
part 'tic_tac_toe_state.dart';

class TicTacToeBloc extends Bloc<TicTacToeEvent, TicTacToeState> {
  TicTacToeBloc() : super(const TicTacToeState()) {
    on<TicTacToeCellClicked>(_onTicTacToeCellClicked);
    on<TicTacToeRestarted>(_onTicTacToeRestarted);
  }

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
}
