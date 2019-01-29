import 'package:flutter/material.dart';
import 'package:flutter_intro/model/player.dart';
import 'tic_tac_toe_grid_square.dart';

enum GameState { WON, DRAW, IN_PROGRESS }

class TicTacToeState extends State<TicTacToe> {
  List<int> gameScore = List.filled(9, 0);
  GameState hasGameBeenWon = GameState.IN_PROGRESS;
  Player player1 = new Player(1, 'Player 1');
  Player player2 = new Player(2, 'Player 2');
  Player activePlayer;

  @override
  void initState() {
    super.initState();
    // Additional initialization of the State
    this.activePlayer = this.player1;
  }

  void onTapFunction(index) {
    if (gameScore[index] == 0 && this.hasGameBeenWon == GameState.IN_PROGRESS) {
      gameScore[index] = this.activePlayer == player1 ? 1 : -1;
      this.setState(() {
        gameScore = gameScore;
        activePlayer =
            this.activePlayer == this.player1 ? this.player2 : this.player1;
      });
      print(this.activePlayer.playerName + " has tapped this square");
    } else {
      print("this square has been clicked already");
    }
    if (gameScore.every((value) => value != 0) &&
        this.hasGameBeenWon == GameState.IN_PROGRESS) {
      this.setState(() {
        hasGameBeenWon = GameState.DRAW;
      });
      print('Game is a draw');
    }
  }

  bool checkIfToggled(int index) {
    return this.gameScore[index] != 0;
  }

  void onPressResetBoard(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('New Game', style: TextStyle(
        color: Colors.black
      ),),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.white,
    ));
    this.setState(() {
      gameScore = List.filled(9, 0);
      hasGameBeenWon = GameState.IN_PROGRESS;
    });
  }

  void checkIfGameHasWon() {
    List<List<int>> winningIndexCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (List<int> winningCombo in winningIndexCombinations) {
      if (winningCombo.every((index) => this.gameScore[index] > 0) ||
          winningCombo.every((index) => this.gameScore[index] < 0)) {
        print(this.activePlayer.playerName + " has won");
        this.setState(() {
          this.hasGameBeenWon = GameState.WON;
          this.activePlayer.gamesWon++;
        });
        break;
      }
    }
  }

  Widget generatePlayerScore(Player player) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            player.playerName + " has won",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            player.gamesWon.toString() + " games",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    checkIfGameHasWon();

    GridView grid = GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.all(20),
      children: List.generate(
          9,
          (index) => new TicTacToeGridSquare(
              onTapFunction: onTapFunction,
              index: index,
              isToggled: checkIfToggled(index),
              score: gameScore[index])),
      scrollDirection: Axis.vertical,
      // TODO: Prevent scrolling
      shrinkWrap: true,
    );
    String messageBoxText;
    switch (this.hasGameBeenWon) {
      case GameState.DRAW:
        {
          messageBoxText = "The game is a tie! Try again?";
        }
        break;
      case GameState.IN_PROGRESS:
        {
          messageBoxText = this.activePlayer.playerName + "'s turn";
        }
        break;
      case GameState.WON:
        {
          messageBoxText = this.activePlayer.playerName + " has won the game!";
        }
    }
    Container messageBox = Container(
      height: 75,
      child: Center(
          child: Text(
        messageBoxText,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
      )),
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
    );

    Container scoreboard = Container(
      padding: EdgeInsets.all(20),
      
      child: Row(
        children: <Widget>[
          generatePlayerScore(this.player1),
          generatePlayerScore(this.player2),
        ],
      ),
      // decoration:
          // BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
    );
    return MaterialApp(
        title: 'Tic Tac Toe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Tic Tac Toe",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage("assets/images/chalkboard.jpg"),
                          fit: BoxFit.cover)),
                  child: ListView(
                    children: <Widget>[
                      grid,
                      scoreboard,
                      messageBox,
                      FloatingActionButton(
                        child: Icon(Icons.refresh),
                        onPressed: () => onPressResetBoard(context),
                      ),
                    ],
                  ));
            })));
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key key}) : super(key: key);
  @override
  TicTacToeState createState() => TicTacToeState();
}
