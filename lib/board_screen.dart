import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tetris/constants.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';

//game board
List<List<Tetromino?>> gameBoard = List.generate(
  columnLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.L);

  @override
  void initState() {
    super.initState();
    StartGame();
  }

  StartGame() {
    currentPiece.init();
    Duration frameRate = const Duration(milliseconds: 400);

    // //tick
    // Timer.periodic(frameRate, (timer) {
    //   setState(() {
    //     //if(checkLanding()) {
    //     checkLanding();
    //     currentPiece.move(Direction.down);
    //     // }
    //   });
    // });
    gameLoop(frameRate);
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= columnLength || col < 0 || col >= rowLength || gameBoard[row][col] != null) {
          return true;
      }

    }
    return false;
  }

  bool checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = (currentPiece.position[i] % rowLength);
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      createNewPiece();
      return false;
    }
    return true;
  }

  void createNewPiece() {
    Random random = Random();
    Tetromino type = Tetromino.values[random.nextInt(Tetromino.values.length)];
    setState(() {
      currentPiece = Piece(type: type);
      currentPiece.init();
    });
  }

  //
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        if(checkLanding()) {
          currentPiece.move(Direction.down);
        }
      });
    });
  }

  void onMove(Direction direction){
    if(!checkCollision(direction)){
      setState(() {
        currentPiece.move(direction);
      });
    }
  }


  onRotate(){
    setState(() {
      currentPiece.rotate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: rowLength * columnLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;

                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      color: tetrominoColors[currentPiece.type]!,
                      child: index,
                    );
                  } else if (gameBoard[row][col] != null) {
                    //final Tetromino? tetrominoType = gameBoard[row][col];
                    final Color? color = tetrominoColors[gameBoard[row][col]];
                    return Pixel(
                      color: color!,
                      child: '',
                    );
                  } else {
                    return Pixel(
                      color: Colors.grey[900]!,
                      child: index,
                    );
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () => onMove(Direction.left),
                    icon: Icon(CupertinoIcons.left_chevron, color: Colors.redAccent,)),
                IconButton(onPressed: onRotate,
                    icon: Icon(Icons.rotate_right_sharp, color: Colors.redAccent,)),
                IconButton(onPressed: () => onMove(Direction.right),
                    icon: Icon(CupertinoIcons.right_chevron, color: Colors.redAccent,)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
