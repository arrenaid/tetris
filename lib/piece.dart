import 'package:flutter/material.dart';

import 'constants.dart';

class Piece{
  Tetromino type;
  Piece({required this.type});

  List<int> position = [];

  Color get color{
    return tetrominoColors[type] ?? Colors.white;
  }

  init(){
    switch(type){
      case Tetromino.L:
        position = [4,14,24,25];
        break;
      case Tetromino.J:
        position = [5,15,25,24];
        break;
      case Tetromino.I:
        position = [3,4,5,6];
        break;
      case Tetromino.O:
        position = [4,14,5,15];
        break;
      case Tetromino.S:
        position = [14,15,5,6];
        break;
      case Tetromino.Z:
        position = [4,5,15,16];
        break;
      case Tetromino.T:
        position = [5,15,25,14];
      // case Tetromino.L:
      //   position = [-4,-14,-24,-25];
      //   break;
      // case Tetromino.J:
      //   position = [-5,-15,-25,-24];
      //   break;
      // case Tetromino.I:
      //   position = [-3,-4,-5,-6];
      //   break;
      // case Tetromino.O:
      //   position = [-4,-14,-5,-15];
      //   break;
      // case Tetromino.S:
      //   position = [-14,-15,-5,-6];
      //   break;
      // case Tetromino.Z:
      //   position = [-4,-5,-15,-16];
      //   break;
      // case Tetromino.T:
      //   position = [-5,-15,-25,-14];
      default:
    }
  }

  bool checkCollision(Direction direction){
    var twin = position;
    for(int i = 0; i < twin.length; i++ ){
      int row = (twin[i] / rowLength).floor();
      int col = (twin[i]% rowLength);
    }
    return false;
  }

  move(Direction direction){
    switch(direction){
      case Direction.down:
        for(int i = 0; i < position.length; i++){
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for(int i = 0; i < position.length; i++){
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for(int i = 0; i < position.length; i++){
          position[i] += 1;
        }
        break;
      default:
    }
  }

  int _rotationState = 1;
  void rotate(){
    List<int> newPosition = [];

    switch(type){
      case Tetromino.L:
        switch(_rotationState){
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            position = newPosition;
            _rotationState = (_rotationState + 1) % 4;
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            position = newPosition;
            _rotationState = (_rotationState + 1) % 4;
            break;
          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            position = newPosition;
            _rotationState = (_rotationState + 1) % 4;
            break;
          case 3:
            newPosition = [
              position[1] - rowLength +1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            position = newPosition;
            _rotationState = (_rotationState + 1) % 4;
            break;
          default:
        }
        break;
      default:
    }
  }
}