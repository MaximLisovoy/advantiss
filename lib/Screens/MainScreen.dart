import 'package:flutter/material.dart';
import 'package:advantiss/Components/ImageItem.dart';
import 'package:advantiss/Components/LoadWidget.dart';

const url = "https://picsum.photos/400/600?random=";

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int get count => images.length;
  List<String> images = List<String>.generate(10, (counter) => "https://picsum.photos/400/600?random=$counter");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadMoreGrid(
        isFinish: count >= 100,
        onLoadMore: _loadMore,
        whenEmptyLoad: false,
        delegate: const DefaultLoadMoreDelegate(),
        child: GridView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ImageItem(images[index]);
          },
          itemCount: count,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1.5,
            mainAxisSpacing: 1.5),
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds:2));
    load();
    return true;
  }

  void load() {
    setState(() {
      images.addAll(List.generate(10, (counter) => "https://picsum.photos/400/600?random=${images.length+counter}"));
    });
  }

}
