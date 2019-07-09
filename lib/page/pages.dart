import 'package:flutter/material.dart';

/// 多个页面布局
class PagesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pages',
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  PageController _pageController = new PageController(initialPage: 2);

  final Map<String, Widget> pages = <String, Widget>{
    'Page one': Center(
      child: Text('Page one'),
    ),
    'Page two': Center(
      child: Text('Page two'),
    ),
    'Page three': Feed(),
  };

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                const Color.fromARGB(255, 253, 72, 72),
                const Color.fromARGB(255, 87, 97, 249),
              ],
                  stops: [
                0,
                1
              ])),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Pages',
                style: textTheme.headline.copyWith(
                  color: Colors.grey.shade800.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: const Color(0x00000000),
          appBar: AppBar(
            backgroundColor: const Color(0x00000000),
            elevation: 0,
            leading: Center(
              child: ClipOval(
                child: Image.network(
                  'https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
              ),
            ],
            title: const Text('songs'),
            bottom: CustomTabBar(
              pageController: _pageController,
              pageNames: pages.keys.toList(),
            ),
          ),
          body: PageView(
            controller: _pageController,
            children: pages.values.toList(),
          ),
        ),
      ],
    );
  }
}

class CustomTabBar extends AnimatedWidget implements PreferredSizeWidget {
  CustomTabBar({this.pageController, this.pageNames})
      : super(listenable: pageController);

  final PageController pageController;
  final List<String> pageNames;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      height: 40,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade800.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: new List.generate(pageNames.length, (int index) {
          return InkWell(
            child: Text(
              pageNames[index],
              style: textTheme.subhead.copyWith(
                  color:
                      index == pageController.page ? Colors.blue : Colors.grey
//                  color: Colors.white
//                      .withOpacity(index == pageController.page ? 1.0 : 0.2)
                  ),
            ),
            onTap: () {
              pageController.animateToPage(index,
                  duration: const Duration(microseconds: 300),
                  curve: Curves.easeOut);
            },
          );
        }),
      ),
    );
  }

  @override
  Size get preferredSize => new Size(0, 40);
}

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Song(
          title: 'Trapadelic lobo',
          author: 'lillobobeats',
          likes: 4,
          isLike: true,
        ),
        new Song(title: 'Different', author: 'younglowkey', likes: 23),
        new Song(title: 'Future', author: 'younglowkey', likes: 2),
        new Song(title: 'ASAP', author: 'tha_producer808', likes: 13),
        new Song(title: '🌲🌲🌲', author: 'TraphousePeyton'),
        new Song(title: 'Something sweet...', author: '6ryan'),
        new Song(title: 'Sharpie', author: 'Fergie_6'),
      ],
    );
//    return ListView.builder(itemBuilder: (BuildContext context, int position) {
//      _createWidget(position);
//    });
  }
}

Widget _createWidget(int position) {
  return new Song(
    title: '$position',
    author: 'author $position',
    likes: position + 10,
  );
}

class Song extends StatefulWidget {
  const Song({this.title, this.author, this.likes, this.isLike: false});

  final String title;
  final String author;
  final int likes;
  final bool isLike;

  @override
  SongState createState() {
    return new SongState(title: title, author: author, likes: likes, isLike: isLike);
  }
}

class SongState extends State<Song> {
  SongState({this.title, this.author, this.likes, this.isLike: false});
  final String title;
  final String author;
  final int likes;
  bool isLike;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: new IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 4, bottom: 4, right: 10),
              child: CircleAvatar(
                backgroundImage: new NetworkImage(
                    'http://thecatapi.com/api/images/get?format=src'
                        '&size=small&type=jpg#${title.hashCode}'),
                radius: 20,
              ),
              padding: const EdgeInsets.all(1.0), // borde width
              decoration: new BoxDecoration(
                color: const Color(0xFFFFFFFF), // border color
                shape: BoxShape.circle,
              )
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      title,
                      style: textTheme.subhead,
                    ),
                    Text(
                      author,
                      style: textTheme.caption,
                    )
                  ],
                )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
//              padding: const EdgeInsets.all(5),
              child: InkWell(
                child: Icon(
                  Icons.play_arrow,
                  size: 40,
                ),
                onTap: () {

                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: isLike ? Colors.blue : null,
                      size: 25,
                    ),
                    Text('${likes ?? ''}', style: TextStyle(color: isLike ? Colors.blue : null),),
                  ],
                ),
                onTap: () {
                  setState(() {
                    isLike = !isLike;
                    print('isLike $isLike');
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
