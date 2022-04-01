import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/tic_tac_toe/bloc/tic_tac_toe_bloc.dart';

import '../../theme/colors.dart';

class TicTacToePage extends StatelessWidget {
  const TicTacToePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicTacToeBloc(),
      child: const TicTacToeView(),
    );
  }
}

class TicTacToeView extends StatelessWidget {
  const TicTacToeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const StatusMessage(),
            const Expanded(child: Board()),
            ElevatedButton.icon(
              icon: const Icon(Icons.replay),
              onPressed: () {
                context.read<TicTacToeBloc>().add(TicTacToeRestarted());
              },
              label: const Text('Restart Game'),
              style: ElevatedButton.styleFrom(primary: MainColor.accentColor),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicTacToeBloc, TicTacToeState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state.status != GameStatus.playing,
          child: Container(
            margin: const EdgeInsets.all(10),

            ///Widget that builds the Board
            child: GridView.count(
              physics: const ClampingScrollPhysics(),
              crossAxisCount: 3,
              children: [
                ///For that evaluates the value of each cell
                for (var i = 0; i < state.board.length; i++)
                  Builder(
                    builder: (context) {
                      final value = state.board[i];
                      final isX = value < 0;
                      final isO = value > 0;
                      final text = () {
                        if (isX) {
                          return 'O';
                        }
                        if (isO) return 'X';
                        return ' ';
                      }();

                      /// Widget that represents every cell
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: MainColor.secondaryColor,
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            context.read<TicTacToeBloc>().add(
                                  TicTacToeCellClicked(i),
                                );
                          },
                          child: Center(
                            child: Text(
                              text,
                              style: TextStyle(
                                color: isX ? MainColor.x : MainColor.o,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StatusMessage extends StatelessWidget {
  const StatusMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<TicTacToeBloc, TicTacToeState>(
      builder: (context, state) {
        final text = () {
          if (state.status == GameStatus.tie) {
            return "It's A Draw";
          } else if (state.status == GameStatus.endGame) {
            if (!state.isXTurn) return 'O wins!';
            return 'X wins!';
          } else {
            if (state.isXTurn) return 'X Turn!';
            return 'O Turn';
          }
        }();
        return SizedBox(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 40),
          ),
          height: boardWidth * 0.3,
          // width: boardWidth,
        );
      },
    );
  }
}
