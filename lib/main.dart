import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
        brightness: Brightness.light,
      ),
      home: const TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({Key? key}) : super(key: key);

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';
  bool _isDraw = false;
  int _scoreX = 0;
  int _scoreO = 0;

  void _handleTap(int index) {
    if (_board[index] == '' && _winner == '' && !_isDraw) {
      setState(() {
        _board[index] = _currentPlayer;
        _winner = _checkWinner();
        if (_winner == '') {
          _isDraw = _checkDraw();
          if (!_isDraw) {
            _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
          }
        } else {
          if (_winner == 'X') {
            _scoreX++;
          } else {
            _scoreO++;
          }
        }
      });
    }
  }

  String _checkWinner() {
    const List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ];
    for (var pattern in winPatterns) {
      if (_board[pattern[0]] != '' &&
          _board[pattern[0]] == _board[pattern[1]] &&
          _board[pattern[1]] == _board[pattern[2]]) {
        return _board[pattern[0]];
      }
    }
    return '';
  }

  bool _checkDraw() {
    return !_board.contains('');
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _winner = '';
      _isDraw = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Tic Tac Toe'),
        backgroundColor: CupertinoColors.systemBackground,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _resetGame,
          child: const Text('Reset'),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildScoreCard('X', _scoreX, _currentPlayer == 'X'),
                  _buildScoreCard('O', _scoreO, _currentPlayer == 'O'),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildBoard(),
                    if (_winner != '')
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Winner: $_winner',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (_isDraw && _winner == '')
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'It\'s a Draw!',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(String player, int score, bool isCurrentPlayer) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrentPlayer ? CupertinoColors.systemBlue.withOpacity(0.1) : CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentPlayer ? CupertinoColors.systemBlue : CupertinoColors.systemGrey4,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Player $player',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isCurrentPlayer ? CupertinoColors.systemBlue : CupertinoColors.label,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            score.toString(),
            style: TextStyle(
              fontSize: 24,
              color: isCurrentPlayer ? CupertinoColors.systemBlue : CupertinoColors.label,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: List.generate(3, (i) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (j) {
              int index = i * 3 + j;
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.systemGrey4,
                      width: 2,
                    ),
                    color: _board[index] == ''
                        ? CupertinoColors.systemBackground
                        : (_board[index] == 'X'
                            ? CupertinoColors.systemBlue.withOpacity(0.1)
                            : CupertinoColors.systemRed.withOpacity(0.1)),
                  ),
                  child: Center(
                    child: Text(
                      _board[index],
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: _board[index] == 'X'
                            ? CupertinoColors.systemBlue
                            : CupertinoColors.systemRed,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
