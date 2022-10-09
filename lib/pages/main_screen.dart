import 'package:flutter/material.dart';
import 'package:list_todo/main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent[200],
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text('Main page'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Row(
              children: [

                Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 190)),
                      Image.asset('assets/friend.jpg', width: 195, height: 250),
                      //const Padding(padding: EdgeInsets.only(right: 5)),
                      //Image.asset('assets/Dasha.jpg', width: 400, height: 250),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/todo');
                        },
                        child: Text('Перейти далее'),
                      )

                    ],
                ),
                Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 190)),
                    Image.asset('assets/Dasha.jpg', width: 195, height: 250)
                  ],
                ),
              ],
            ),

        )

    );
  }
}
