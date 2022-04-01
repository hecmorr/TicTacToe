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
          children: [Expanded(child: Board())],
        ),
      ),
    );
  }
}

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      physics: const ClampingScrollPhysics(),
      children: [
        Card(
          color: MainColor.secondaryColor,
          elevation: 5,
          child: const InkWell(
            child: Center(
              child: Text(
                ' - ',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
