import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rows',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Rows'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int columns = 5;
  final int rows = 5;
  static const List<String> _kOptions = <String>[
    'ABS',
    'FILL',
    'FILTER',
  ];
  final List<String> alphabet = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

  // final List selected = ["A1:C3"];

  Widget buildFocusCell(context, cell, autofocus) {
    GlobalKey gridItemKey = new GlobalKey();
    bool editMode = false;
    return TableCell(
      child: Focus(
        autofocus: autofocus,
        child: Builder(
          builder: (BuildContext context) {
            final FocusNode focusNode = Focus.of(context);
            final bool hasFocus = focusNode.hasFocus;
            return GestureDetector(
              onTap: () {
                if (!hasFocus) {
                  focusNode.requestFocus();
                  setState(() {
                    selected_column = cell[0];
                    selected_row = int.parse(cell[1]);
                  });
                }
              },
              // onDoubleTap: () {
              //   if (!hasFocus) {
              //     focusNode.requestFocus();
              //     // setState(() {
              //     //   selected_column = cell[0];
              //     //   selected_row = int.parse(cell[1]);
              //     // });
              //     print("Todo: on double tap, change to text field");
              //   }
              // },
              child: hasFocus ? Stack(
                children: [
                  Container(
                    height: 30.0,
                    alignment: Alignment.center,
                    child: Text(cell),
                    decoration: BoxDecoration(
                      // color: editMode ? Color(0xFFfff4cc) : Colors.white,
                      color: Colors.white,
                      border: hasFocus ? Border.all(color: Color(0xFFffc800), width: 2.0) : (bounds_expected.containsKey(cell) ? bounds_expected[cell] : null),
                    ),
                  ),
                  Positioned(bottom:0, right:0, child: SizedBox(width: 6, height: 6,child: Container(color: Color(0xFFffc800),),)),
                ],
              ) : Container(
              height: 30.0,
              alignment: Alignment.center,
              child: Text(cell),
              decoration: BoxDecoration(
                // color: editMode ? Color(0xFFfff4cc) : Colors.white,
                color: Colors.white,
                border: hasFocus ? Border.all(color: Color(0xFFffc800), width: 2.0) : (bounds_expected.containsKey(cell) ? bounds_expected[cell] : null),
              ),
                ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCell(context, cell) {
    return TableCell(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selected_cell = cell;
          });
        },
        child: Container(
          height: 30.0,
          alignment: Alignment.center,
          child: Text(cell),
          decoration: BoxDecoration(
            // color: editMode ? Color(0xFFfff4cc) : Colors.white,
            border: selected_cell == cell ? Border.all(color: Color(0xFFffc800), width: 2.0) : (bounds_expected.containsKey(cell) ? bounds_expected[cell] : null),
          ),
        ),
      ),
    );
  }

  String selected_cell = "C4";
  int selected_row = 4;
  String selected_column = "C";

  // List selected_list_expected = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"];
  List selected_list_expected = [];
  final double bounds_width = 1.0;

  // Map bounds_expected = {
  //   "A1": Border(top: BorderSide(color: Color(0xFFffc800), width: 1.0), left: BorderSide(color: Color(0xFFffc800), width: 1.0)),
  //   "A2": Border(left: BorderSide(color: Color(0xFFffc800), width: 1.0)),
  //   "A3": Border(bottom: BorderSide(color: Color(0xFFffc800), width: 1.0), left: BorderSide(color: Color(0xFFffc800), width: 1.0)),
  //   "B1": Border(top: BorderSide(color: Color(0xFFffc800), width: 1.0)),
  //   // "B2": Border.all(width: 0),
  //   "B3": Border(bottom: BorderSide(color: Color(0xFFffc800), width: 1.0)),
  //   "C1": Border(top: BorderSide(color: Color(0xFFffc800), width: 1.0), right: BorderSide(color: Color(0xFFffc800), width: 1.0)),
  //   "C2": Border(right: BorderSide(color: Color(0xFFffc800), width: 1.0)),
  //   "C3": Border(bottom: BorderSide(color: Color(0xFFffc800), width: 1.0), right: BorderSide(color: Color(0xFFffc800), width: 1.0))
  // };
  Map bounds_expected = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40.0, left: 40.0),
        width: 600,
        height: 300,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            print("onVerticalDragUpdate");
            print(details);
          },
          onHorizontalDragUpdate: (details) {
            print("onHorizontalDragUpdate");
            print(details);
          },
          child: FocusScope(
            child: Table(
              border: TableBorder.all(color: Colors.grey[300]),
              children: [
                //Header
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  children: []..addAll(
                      List.generate(columns + 1, (index) {
                        if (index == 0) return Container(width: 10.0, height: 30.0, color: Colors.white, alignment: Alignment.center);
                        return Container(
                          height: 30.0,
                          width: 10.0,
                          color: selected_column == alphabet[index] ? Colors.grey : Colors.grey[200] ,
                          child: Text(alphabet[index], style: TextStyle(fontWeight: selected_column == alphabet[index] ? FontWeight.bold : FontWeight.normal),),
                          alignment: Alignment.center,
                        );
                      }),
                    ),
                ),
              ]..addAll(
                  //body
                  List.generate(rows, (row_index) {
                    return TableRow(
                      children: []..addAll(
                          List.generate(columns + 1, (c_index) {
                            //First column with Rows num
                            if (c_index == 0)
                              return TableCell(
                                child: Container(
                                  height: 30.0,
                                  width: 10.0,
                                  color: selected_row == (row_index + 1) ? Colors.grey :Colors.grey[200] ,
                                  alignment: Alignment.center,
                                  child: Text((row_index + 1).toString(), style: TextStyle(fontWeight: selected_row == (row_index + 1) ? FontWeight.bold : FontWeight.normal),),
                                ),
                              );
                            //Cell
                            final cell = alphabet[c_index].toUpperCase() + "" + (row_index + 1).toString();
                            return buildFocusCell(context, cell, (selected_cell == cell));
                          }),
                        ),
                    );
                  }),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
