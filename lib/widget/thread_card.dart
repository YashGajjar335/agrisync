import 'package:agrisync/screens/comment_screen.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  bool isSaved = false;
  bool moreThanOneImage = false;
  final List<String> Likes = [];
  var likesCount = 0;

  @override
  void initState() {
    // check the image is one or more than one
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).colorScheme.secondary,
      surfaceTintColor: Theme.of(context).colorScheme.secondaryContainer,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            threadHeader(),
            const SizedBox(
              height: 5,
            ),
            threadImage(),
            const SizedBox(
              height: 5,
            ),
            threadBottom(),
          ],
        ),
      ),
    );
  }

  threadBottom() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const TextLato(
            text:
                "This is a description of the post. try this -> double tap on image -> one tap on image -> tap on all icon "),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      !isLiked
                          ? Icons.thumb_up_alt_outlined
                          : Icons.thumb_up_alt,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    ),
                    const TextLato(
                      text: "10 Likes",
                      paddingAll: 0.0,
                    )
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CommentScreen()));
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.comment_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    ),
                    const TextLato(
                      text: "Comment",
                      paddingAll: 0.0,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    isSaved = !isSaved;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      !isSaved ? Icons.bookmark_outline : Icons.bookmark,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    ),
                    const TextLato(
                      text: "Save",
                      paddingAll: 0.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  threadImage() {
    return InkWell(
      onDoubleTap: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
      onTap: () {
        setState(() {
          moreThanOneImage = !moreThanOneImage;
        });
      },
      child: moreThanOneImage
          ? CarouselSlider(
              items: [
                Image.asset(
                  'assets/smart_farm.jpg',
                  fit: BoxFit.fill,
                  height: 280,
                  width: double.infinity,
                ),
                Image.asset(
                  'assets/smart_farm.jpg',
                  fit: BoxFit.fill,
                  height: 280,
                  width: double.infinity,
                ),
                Image.asset(
                  'assets/smart_farm.jpg',
                  fit: BoxFit.fill,
                  height: 280,
                  width: double.infinity,
                ),
                Image.asset(
                  'assets/smart_farm.jpg',
                  fit: BoxFit.fill,
                  height: 280,
                  width: double.infinity,
                ),
                Image.asset(
                  'assets/smart_farm.jpg',
                  fit: BoxFit.fill,
                  height: 280,
                  width: double.infinity,
                ),
              ],
              options: CarouselOptions(
                height: 280,
                viewportFraction: 1,
                animateToClosest: true,
                autoPlay: true,
                enableInfiniteScroll: false,
                // aspectRatio: 16 / 9,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/farm.png',
                fit: BoxFit.fill,
                height: 280,
                width: double.infinity,
              ),
            ),
    );
  }

  Row threadHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage("assets/app_logo_half.JPG"),
            ),
            Padding(padding: EdgeInsets.all(0.2)),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextLato(
                    text: '  UserName',
                    paddingAll: 0.0,
                  ),
                  TextLato(
                    text: '  Date',
                    paddingAll: 0.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            print("Button Click More");
          },
          child: Icon(
            Icons.more_vert_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 25,
          ),
        ),
      ],
    );
  }
}
