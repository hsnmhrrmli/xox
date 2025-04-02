import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({Key? key}) : super(key: key);

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';

  void _handleTap(int index) {
    if (_board[index] == '') {
      setState(() {
        _board[index] = _currentPlayer;
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Tic Tac Toe'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildBoard(),
          ],
        ),
      ),
    );
  }

  Widget _buildBoard() {
    return Column(
      children: List.generate(3, (i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (j) {
            int index = i * 3 + j;
            return GestureDetector(
              onTap: () => _handleTap(index),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    _board[index],
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
} 