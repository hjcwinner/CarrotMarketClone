import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  Map<String, String> received;
  Detail({Key key, this.received}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  Widget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {}),
      ],
    );
  }

  Widget _bodyWidget() {
    return Container(
      child: Hero(
        tag : widget.received["cid"],
              child: Image.asset(
          widget.received["image"],
          fit: BoxFit.fill,
          width: size.width,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _appbarWidget(),
        body: _bodyWidget());
  }
}
