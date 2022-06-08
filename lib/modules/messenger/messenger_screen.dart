import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  //Arrow Function for one statement
  Widget buildChatItem() => Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://images.yaoota.com/gXrbxWcjlR1pD5oseZB24XWN__A=/trim/yaootaweb-production-ke/media/crawledproductimages/b7e587422cf234fdebf1dda3419225bfc89050f5.jpg'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 3.0,
                  end: 3.0,
                ),
                child: CircleAvatar(
                  radius: 7.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hozan Ageed Farho',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Hello my name is Hozan Ageed Farho',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        //we can not use color property in Container widget
                        // if we use decoration property, in this case we must
                        // use color property inside decoration property
                        //otherwise it gives an error
                        width: 7.0,
                        height: 7.0,
                        decoration: BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle),
                      ),
                    ),
                    Text('02:00 pm'),
                  ],
                ),
              ],
            ),
          )
        ],
      );

  Widget buildStoryItem() => Container(
        width: 60.0,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://images.yaoota.com/gXrbxWcjlR1pD5oseZB24XWN__A=/trim/yaootaweb-production-ke/media/crawledproductimages/b7e587422cf234fdebf1dda3419225bfc89050f5.jpg'),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 3.0,
                    end: 3.0,
                  ),
                  child: CircleAvatar(
                    radius: 7.0,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              'Hozan Ageed Farho',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              //if we have more than 2 lines it will create this (...)
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0, //size of circle
              backgroundImage: NetworkImage(
                  'https://images.yaoota.com/gXrbxWcjlR1pD5oseZB24XWN__A=/trim/yaootaweb-production-ke/media/crawledproductimages/b7e587422cf234fdebf1dda3419225bfc89050f5.jpg'),
            ),
            SizedBox(width: 15.0),
            Text(
              'Chats',
              style: TextStyle(
                  color: Colors.black), //color here by default is white
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.camera_alt,
                  size: 16.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {}),
          IconButton(
              icon: CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.edit, //pen icon
                  size: 16.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text('Search'),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 100.0, //it's necessary to appear the list
                child: ListView.separated(
                  //here there is a SingleChildScrollView by default
                  scrollDirection: Axis.horizontal,
                  // shrinkWrap: true,
                  // we adding the list to other items
                  // we don't need it here because we work inside column
                  itemBuilder: (context, index) => buildStoryItem(),
                  separatorBuilder: (context, index) => SizedBox(width: 20),
                  itemCount: 5,
                ),
              ),
              SizedBox(height: 40.0),
              ListView.separated(
                  shrinkWrap: true, //we adding the list to other items
                  physics:
                      NeverScrollableScrollPhysics(), //to stop (disable) the scroll
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(height: 20.0),
                  itemCount: 15),
            ],
          ),
        ),
      ),
    );
  }
}
