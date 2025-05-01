import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ui_designs/components/custom_list_title.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Music(),
    );
  }
}

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final List<Map<String, String>> musiclist = [
    {
      'title': "Hit3",
      'singer': "Mickey J Meyer",
      'url': "https://mp3teluguwap.net/mp3/2025/Hit%203/Prema%20Velluva.mp3",
      'coverUrl':
          "https://c.saavncdn.com/133/Prema-Velluva-From-Hit-3-Telugu-Telugu-2025-20250323083324-500x500.jpg",
    },
    {
      'title': "Premalo",
      'singer': "Anurag Kulkarni, Sameera Bharadwaj",
      'url': "https://mp3teluguwap.net/mp3/2025/Premalu/Premalo.mp3",
      'coverUrl':
          "https://naasongs.com.co/wp-content/uploads/2025/03/Court-2025.jpg",
    },
    {
      'title': "Temper",
      'singer': "Ranjith Govind, Lipsika",
      'url':
          "https://sencloud.online/mp32/mp3/2000/Temper%20(2015)/One%20More%20Time-SenSongsMp3.Co.mp3",
      'coverUrl':
          "https://naasongs.com.co/wp-content/uploads/2018/05/Temper-2015jpeg-300x300.jpg",
    },
    {
      'title': "Arya 2",
      'singer': "Ranjith",
      'url':
          "https://sencloud.online/mp3/Telugu%20Mp3/All/Arya2(2009)/6-My%20Love%20Is%20Gone-SenSongsMp3.Co.mp3",
      'coverUrl':
          "https://naasongs.com.co/wp-content/uploads/2018/06/aarya-2-jpeg-300x300.jpg",
    },
    {
      'title': "Sound Of Salaar",
      'singer': "Ravi Barsur Team",
      'url': "https://mp3teluguwap.net/mp3/2023/Salaar/Sound%20of%20Salaar.mp3",
      'coverUrl':
          "https://naasongs.com.co/wp-content/uploads/2020/12/Sallar-2021-jpeg.jpg",
    },
    {
      'title': "The Monster Song (KGF@)",
      'singer': "Ravi Basrur",
      'url':
          "https://mp3teluguwap.net/mp3/2022/KGF%202/KGF%202%20-%20Telugu/The%20Monster.mp3",
      'coverUrl':
          "https://naasongs.com.co/wp-content/uploads/2019/05/KGF-2-2020-jpeg-300x300.jpg",
    },
    {
      'title': "Vikram",
      'singer': " Anirudh Ravichander",
      'url':
          "https://mp3teluguwap.net/mp3/2022/Vikram/Vikram%20Title%20Track.mp3",
      'coverUrl':
          "https://naasongs.com.co/wp-content/uploads/2020/10/Vikram-2021-300x300.jpg",
    },
  ];

  String currentTitle = "";
  String currentCover = "";
  String currentSinger = "";
  IconData btnIcon = Icons.play_arrow;

  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentSong = "";

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  void playMusic(String url) async {
    if (currentSong != url) {
      await audioPlayer.stop();
      await audioPlayer.play(UrlSource(url));
      setState(() {
        currentSong = url;
        isPlaying = true;
        btnIcon = Icons.pause;
      });
    } else {
      if (isPlaying) {
        await audioPlayer.pause();
        setState(() {
          isPlaying = false;
          btnIcon = Icons.play_arrow;
        });
      } else {
        await audioPlayer.resume();
        setState(() {
          isPlaying = true;
          btnIcon = Icons.pause;
        });
      }
    }

    // Listen for duration and position updates
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6A1B9A), // Purple
                Color(0xFF8E24AA),
                Color(0xFFD81B60), // Pink
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          '🎵 My Playlist',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                blurRadius: 4.0,
                color: Colors.black38,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6A1B9A), Color(0xFFD81B60)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMItQfBJAY9aaD-8RLi2Y1931Fd_DTnbIh8tMM6qVFIZ34oj6wVBj8O9eJ8sbQEpHu2H0&usqp=CAU', // Placeholder image
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome!',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    'mmanjugovi@gmail.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.library_music),
              title: Text('My Playlist'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About App'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: musiclist.length,
              itemBuilder: (context, index) => customListTitle(
                onTap: () {
                  setState(() {
                    currentTitle = musiclist[index]['title']!;
                    currentCover = musiclist[index]['coverUrl']!;
                    currentSinger = musiclist[index]['singer']!;
                  });
                  playMusic(musiclist[index]['url']!);
                },
                title: musiclist[index]['title']!,
                singer: musiclist[index]['singer']!,
                cover: musiclist[index]['coverUrl']!,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x55212121),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Slider.adaptive(
                  value: position.inSeconds
                      .toDouble()
                      .clamp(0.0, duration.inSeconds.toDouble()),
                  min: 0.0,
                  max: duration.inSeconds > 0
                      ? duration.inSeconds.toDouble()
                      : 1.0,
                  onChanged: (value) async {
                    final newPosition = Duration(seconds: value.toInt());
                    await audioPlayer.seek(newPosition);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          image: currentCover.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(currentCover),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentTitle,
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              currentSinger,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          playMusic(currentSong);
                        },
                        icon: Icon(btnIcon),
                        iconSize: 40.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
