import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'BienvenuePge.dart';
import 'Detection.dart';
import 'Home.dart';

class parameters extends StatefulWidget {
  const parameters({Key? key}) : super(key: key);

  @override
  _parametersState createState() => _parametersState();
}
class _parametersState extends State<parameters>{
  bool value = false;

  @override
  //App widget tree
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Paramètres'),
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {},
          ), //IcoButton
        ),
        backgroundColor: Colors.grey,//AppBar
        body:

        Center(

          /** Card Widget **/
          child:
          Column(children: [
            Card(
                child: Padding(

                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(

                    child: Column(
                      children: [

                        Text('Langue',style:  TextStyle(fontSize: 17.0),),


                        SizedBox(height: 10),
                        Text('Vous pouvez changer la languede l application en électionnant celle que vous souhaitez. '),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ), //SizedBox
                            Icon(Icons.flag),
                            Text(
                              'English ',
                              style: TextStyle(fontSize: 15.0),
                            ), //Text
                            SizedBox(width: 5), //SizedBox
                            /** Checkbox Widget **/
                            Checkbox(
                              value: this.value,
                              onChanged: (bool? value)
                              {
                                setState(() {
                                  this.value = value!;
                                }
                                );
                              },
                            ), //Checkbox

                          ], //<Widget>[]
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ), //SizedBox
                            Text(
                              'Francais ',
                              style: TextStyle(fontSize: 15.0),
                            ), //Text
                            SizedBox(width: 10), //SizedBox
                            /** Checkbox Widget **/
                            Checkbox(
                              value: this.value,
                              onChanged: (bool? value)
                              {
                                setState(() {
                                  this.value = value!;
                                }
                                );
                              },
                            ), //Checkbox

                          ], //<Widget>[]
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ), //SizedBox
                            Text(
                              'العربية ',
                              style: TextStyle(fontSize: 17.0),
                            ), //Text
                            SizedBox(width: 10), //SizedBox
                            /** Checkbox Widget **/
                            Checkbox(
                              value: this.value,
                              onChanged: (bool? value)
                              {
                                setState(() {
                                  this.value = value!;
                                }
                                );
                              },
                            ), //Checkbox

                          ], //<Widget>[]
                        ),//Row
                      ],
                    ), //Column
                  ), //SizedBox
                ), //Padding
              ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 400,
                  height: 100,
                  child: Column(
                    children: [
                      //Text
                      SizedBox(height: 10),
                      Text('Luminosité automatique',style:  TextStyle(fontSize: 17.0),),

                      SizedBox(height: 10),
                      Text('Vous pouvez changer la languede l application en électionnant celle que vous souhaitez. '),

                    ],
                  ), //Column
                ), //SizedBox
              ), //Padding
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 430,
                  height: 200,
                  child: Column(
                    children: [
                      //Text
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ), //SizedBox
                          Text(
                            'english: ',
                            style: TextStyle(fontSize: 17.0),
                          ), //Text
                          SizedBox(width: 10), //SizedBox
                          /** Checkbox Widget **/
                          Checkbox(
                            value: this.value,
                            onChanged: (bool? value)
                            {
                              setState(() {
                                this.value = value!;
                              }
                              );
                            },
                          ), //Checkbox

                        ], //<Widget>[]
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ), //SizedBox
                          Text(
                            'english: ',
                            style: TextStyle(fontSize: 17.0),
                          ), //Text
                          SizedBox(width: 10), //SizedBox
                          /** Checkbox Widget **/
                          Checkbox(
                            value: this.value,
                            onChanged: (bool? value)
                            {
                              setState(() {
                                this.value = value!;
                              }
                              );
                            },
                          ), //Checkbox

                        ], //<Widget>[]
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ), //SizedBox
                          Text(
                            'english: ',
                            style: TextStyle(fontSize: 17.0),
                          ), //Text
                          SizedBox(width: 10), //SizedBox
                          /** Checkbox Widget **/
                          Checkbox(
                            value: this.value,
                            onChanged: (bool? value)
                            {
                              setState(() {
                                this.value = value!;
                              }
                              );
                            },
                          ), //Checkbox

                        ], //<Widget>[]
                      ),//Row
                    ],
                  ), //Column
                ), //SizedBox
              ), //Padding
            ),

          ],)








          //Card
        ) //Center//Center
      ), //Scaffold
    ); //MaterialApp
  }
  }
  void _back(BuildContext context) {
    final route=MaterialPageRoute(builder: (BuildContext context){
      return HomePage();

    });
    Navigator.of(context).push(route);
  }


