import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_posts/views/uis/post_detail_screen.dart';
import 'package:timer_posts/views/utils/colors/colors.dart';
import 'package:timer_posts/views/utils/extainsion.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../controllers/providers/post_provider.dart';
import '../../models/timer.dart';
import '../utils/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostController postController = Get.put(PostController());
  List<TimerData> _items = [];

  @override
  void initState() {
    init();

    super.initState();
  }

  init() async {
    await postController.loadPosts();
    for (int i = 0; i < postController.posts.length; i++) {
      List<int> numbers = [10, 20, 25];
      Random random = Random();
      int randomNumber = numbers[random.nextInt(numbers.length)];
      _items.add(TimerData(id: i, time: randomNumber));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Viewer"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Hero(tag: "splash", child: Image.asset(appLogo)),
        ),
        leadingWidth: 35,
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return Center(child: CircularProgressIndicator( color: primaryColor,));
        }
        if (postController.errorMessage.isNotEmpty) {
          return Center(child: Text(postController.errorMessage.value));
        }
        return ListView.builder(
          itemCount: postController.posts.length,
          itemBuilder: (context, index) {
            var post = postController.posts[index];
            var item = _items[index];
            return VisibilityDetector(
              key: Key('${post.id}'),
              onVisibilityChanged: (visibilityInfo) {
                if (visibilityInfo.visibleFraction > 0) {
                  startTimer(item);
                } else {
                  pauseTimer(item);
                }
              },
              child: GestureDetector(
                onTap: () {
                  postController.markAsRead(post.id);
                  pauseTimer(item);
                  Get.to(() => PostDetailScreen(postId: post.id))?.then(
                    (value) {
                      startTimer(item);
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: post.isRead ? Colors.white : Colors.yellow[100],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: TextStyle(fontSize: 20, color: secondaryColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.timer,
                            color: primaryColor,
                          ),
                          Container(
                            width: 90,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              margin: const EdgeInsets.only(left: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: primaryColor)),
                              child: Text(item.time.toMinSec(),
                                  style: const TextStyle(
                                      fontSize: 16, color: secondaryColor))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void startTimer(TimerData item) {
    if (!item.isRunning) {
      item.isRunning = true;
      item.timer = Timer.periodic(Duration(seconds: 1), (timer) {

        if (item.isRunning) {
          setState(() {
            item.time++;
          });
        }
      });
    }
  }

  void pauseTimer(TimerData item) {
    if (item.isRunning) {
      item.isRunning = false;
      item.timer?.cancel();
    }
  }
}
