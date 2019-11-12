import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
  
class _HomeScreenState extends State<HomeScreen> {

  List<String> _todoItems = [];

  void _addTodoItem(String task){
    if(task.length > 0){
      setState( () => _todoItems.add(task));
    }
  }
  void _removeTodoItem(int index){
    setState(()=> _todoItems.removeAt(index));
  }
  void _promptRemoveTodoItem(int index){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text('Mark "${_todoItems[index]}" as done?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('MARK AS DONE'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }
  void _pushAddTodoScreen(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context){
          return new Scaffold(
            appBar: new AppBar(
              title: new Text(
                'Truedo'.toUpperCase(),
                style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.w400,)
              ),
              centerTitle: true,
            ),
            body: new SafeArea(
              child: new Center(
                child: new TextField(
                  autofocus: true,
                  onSubmitted: (value){
                    _addTodoItem(value);
                    Navigator.pop(context);
                  },
                  decoration: new InputDecoration(
                    hintText: "Enter your task",
                    contentPadding: const EdgeInsets.all(16.0)
                  ),
                ),
              ),
            ),
          );
        }
      )
    );
  }
  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index],index);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _promptRemoveTodoItem(index)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Truedo'.toUpperCase(),
          style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.w400,)
        ),
        centerTitle: true,
      ),
      body: new SafeArea(
        child: _buildTodoList()
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add)
      ),
    );
  }
}