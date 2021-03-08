import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  Map<String, String> received;
  Detail({Key key, this.received}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Size size;
  List<Map<String, String>> imgList;
  int _current;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    imgList = [
      {"id": "0", "url": widget.received["image"]},
      {"id": "1", "url": widget.received["image"]},
      {"id": "2", "url": widget.received["image"]},
      {"id": "3", "url": widget.received["image"]},
      {"id": "4", "url": widget.received["image"]}
    ];
    _current = 0;
  }

  Widget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.white,
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {}),
      ],
    );
  }

  Widget _bodyWidget() {
    return Container(
      child: Stack(
        children: [
          Hero(
            tag: widget.received["cid"],
            child: CarouselSlider(
              options: CarouselOptions(
                  height: size.width,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                    print(index);
                  }),
              items: imgList.map((map) {
                print(map);
                return Container(
                  width: size.width,
                  height: size.width,
                  color: Colors.red,
                  child: Image.asset(
                    map['url'],
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((map) {
                print(_current);
                print(map);
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == int.parse(map['id'])
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  _bottomNavbar() {
    return Container(
      width: size.width,
      height: 55,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavbar(),
    );
  }
}
