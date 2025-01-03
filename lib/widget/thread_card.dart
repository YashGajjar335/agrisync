import 'package:flutter/material.dart';

class ThreadCard extends StatefulWidget {
  const ThreadCard({
    super.key,
  });

  @override
  State<ThreadCard> createState() => _ThreadCardState();
}

class _ThreadCardState extends State<ThreadCard> {
  bool isLiked = false;
  final List<String> Likes = [];
  var likesCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(children: [
        postHeader(),
        postImage(),
        postIcons(),
        postDetails(),
      ]),
    );
  }

  Container postDetails() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '128 likes',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                child: Image.asset(
                  'assets/profile.jpg',
                  width: 30,
                  height: 30,
                ),
              ),
              Text(
                '128 likes \t',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                'this is post discription.',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container postIcons() {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 6, 0),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
          IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.save_alt_sharp)),
        ],
      ),
    );
  }

  Container postImage() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
      child: Image.asset(
        'assets/post1.jpg',
        fit: BoxFit.fill,
        height: 280,
        width: double.infinity,
      ),
    );
  }

  Row postHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 23,
          child: Image.asset(
            'assets/profile.jpg',
            width: 50,
            height: 50,
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('  UserName',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          Text(
            '  Date',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ]),
        Spacer(flex: 2),
        IconButton(
            onPressed: () {
              print('Open menu button');
            },
            icon: Icon(Icons.more_vert_outlined))
      ],
    );
  }
}
