import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tic_tac_toe_event.dart';
part 'tic_tac_toe_state.dart';

class TicTacToeBloc extends Bloc<TicTacToeEvent, TicTacToeState> {
  TicTacToeBloc() : super(const TicTacToeState());
}
