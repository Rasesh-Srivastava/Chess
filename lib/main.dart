import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
final greenColor=const m.Color(0xff00a6ac);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ChessBoardController controller = ChessBoardController();
  BoardColor x = BoardColor.orange;
  PlayerColor y = PlayerColor.white;
  int num=1;
  int flag =0;
  int i=0;
  bool moving = true;
  String s="Starting Position - Player 1 to Move";
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.black,
        title: const Text("Chess"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          const SizedBox(height: 2),
          Container(
            color: Colors.blueGrey.shade300,
            height: 30,
            child: Align(alignment: Alignment.center,child: Text(s,
            style: TextStyle(color: Colors.green.shade900,
            fontSize: 15,fontWeight: FontWeight.bold),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Player ${3-num}",style: const TextStyle(fontSize: 15,
                  fontWeight: FontWeight.bold),),
              OutlinedButton(onPressed: (){
                setState(() {
                  if(!controller.isGameOver() && flag!=1) {
                    s = "Game Over - Player ${3-num} Resigned, Player ${num} Wins";
                    flag=1;
                    moving = false;
                  }
                });
              },
                child: const Text("Resign",
                  style:
                  TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 10),
          Center(
          child: ChessBoard(
            controller: controller,
            boardColor: x,
            boardOrientation: y,
            enableUserMoves: moving,
            onMove: () {
              setState(() {
                i++;
                if(controller.isCheckMate())
                {
                  if(i%2 != 0) {
                    s = "CheckMate - Game Over, Player 1 Wins";
                  }
                  else if(i%2 == 0) {
                    s = "CheckMate - Game Over, Player 2 Wins";
                  }
                  moving = false;
                }
                else if(controller.isStaleMate())
                {
                  s = "StaleMate (Draw) - Game Over";
                  moving = false;
                }
                else if(controller.isInsufficientMaterial())
                {
                  s = "Insufficient Material (Draw) - Game Over";
                  moving = false;
                }
                else if(controller.isThreefoldRepetition())
                {
                  s = "Threefold Repetition (Draw) - Game Over";
                  moving = false;
                }
                else if(controller.isDraw())
                  {
                    s = "Draw - Game Over";
                    moving = false;
                  }
                if(i%2!=0 && !controller.isGameOver())
                  {
                    if(controller.isInCheck())
                      {
                        s = "Player 2 to Move & is in Check";
                      }
                    else {
                      s = "Player 2 to Move";
                    }
                  }
                if(i%2==0 && !controller.isGameOver())
                {
                  if(controller.isInCheck())
                  {
                    s = "Player 1 to Move & is in Check";
                  }
                  else {
                    s = "Player 1 to Move";
                  }
                }
              });
            },
          ),
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Player ${num}",style: const TextStyle(fontSize: 15,
              fontWeight: FontWeight.bold),),
              OutlinedButton(onPressed: (){
                setState(() {
                  if(!controller.isGameOver() && flag != 1) {
                    s = "Game Over - Player ${num} Resigned, Player ${3-num} Wins";
                    flag=1;
                    moving = false;
                  }
                });
              },
                  child: const Text("Resign",
                    style:
                    TextStyle(fontWeight: FontWeight.bold,fontSize:15,color: Colors.red),
                  ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.center,
              child: Text("Total Number of Moves Played: ${controller.getMoveCount()-1}")),
          const SizedBox(height: 2),
          const Divider(
            color: Colors.black,
            thickness: 2,
          ),
          const Align(
            alignment: Alignment.center,
              child:
          Text("Change Board Color",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
          const SizedBox(height: 2),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: (){
                  setState(() {
                    x=BoardColor.darkBrown;
                  });
                },
                    child: const Text("Dark Brown"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const m.Color(0xff7e6c62),
                    ),
                ),
                ElevatedButton(onPressed: (){
                  setState(() {
                    x=BoardColor.orange;
                  });
                },
                  child: const Text("Orange"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const m.Color(0xffcc723a),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      x=BoardColor.green;
                    });
                  },
                    child: const Text("Green"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                  ),
                ),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      x=BoardColor.brown;
                    });
                  },
                    child: const Text("Brown"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const m.Color(0xffb58763),

                    ),
                  ),
                ],
              ),
          const Divider(
            color: Colors.black,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              ElevatedButton(
                onPressed: (){
                  setState(() {
                    moving=true;
                    i=0;
                    flag=0;
                    s = "Starting Position - Player 1 to Move";
                    controller.resetBoard();
                    // controller.undoMove();
                  });
                },
                child: const Text("New Game",style: TextStyle(fontSize: 15),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade300,
                  foregroundColor: Colors.green.shade900,
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    y==PlayerColor.white?y=PlayerColor.black:y=PlayerColor.white;
                    num = 3 - num;
                  });
                },
                child: const Text("Flip Board",style: TextStyle(fontSize: 15),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade300,
                  foregroundColor: Colors.green.shade900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
