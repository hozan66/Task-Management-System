import 'package:flutter/Material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(Icons.menu),
        title: Text('First App'),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important),
            onPressed: () {
              print('Notification is clicked!');
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('search is clicked!');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
                50.0), //with const keyword it will execute in compiler time
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip
                  .antiAliasWithSaveLayer, //it works with BorderRadius.circular
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg'),
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover, //it will zoom the image a little bit
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    // padding: EdgeInsetsDirectional.only(top: 10.0, bottom: 10.0), // with Directional the child has start and end instead of left and right
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'Flower',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
