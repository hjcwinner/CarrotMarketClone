import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/manor_temperature.dart';

class Detail extends StatefulWidget {
  Map<String, String> received;
  Detail({Key key, this.received}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Size size;
  List<Map<String, String>> imgList;
  int _current;
  double scollposition = 0;
  ScrollController _controller = ScrollController();
  AnimationController _animationController;
  Animation _colorTween;
  bool isMyFavoriteContent;

  @override
  void initState() {
    super.initState();
    isMyFavoriteContent = false;
    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _controller.addListener(() {
      setState(() {
        if (_controller.offset > 255) {
          scollposition = 255;
        } else {
          scollposition = _controller.offset;
        }
        _animationController.value = scollposition / 255;
      });
    });
  }

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

  Widget _makeIcon(IconData icon) {
    return AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) => Icon(
              icon,
              color: _colorTween.value,
            ));
  }

  Widget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.white.withAlpha(scollposition.toInt()),
      elevation: 0,
      leading: IconButton(
        icon: AnimatedBuilder(
            animation: _colorTween,
            builder: (context, child) => Icon(
                  Icons.arrow_back,
                  color: _colorTween.value,
                )),
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.white,
      ),
      actions: [
        IconButton(icon: _makeIcon(Icons.share), onPressed: () {}),
        IconButton(icon: _makeIcon(Icons.more_vert), onPressed: () {}),
      ],
    );
  }

  Widget _makeSliderImage() {
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
                  }),
              items: imgList.map((map) {
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

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: Container(child: Image.asset('assets/images/user.png'), width: 50, height: 50,),
          // )
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.asset('assets/images/user.png').image,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '코딩매니아',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              Text('남양주시 다산동')
            ],
          ),
          Expanded(child: ManorTemperature(manorTemp: 37.5))
        ],
      ),
    );
  }

  Widget _contentText() {
    return Container(
      // alignment: Alignment.bottomLeft,
      // color: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.received["title"],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text(
            "디지털/가전 · 22시간전",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            '선물받은 새 상품이고 \n상품꺼재보기만 했습니다 \n거래는 직거래만 가능합니다',
            style: TextStyle(fontSize: 18, color: Colors.black, height: 1.5),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '채팅 3 · 관심17 · 조회295',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  otherContents() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "판매자님의 판매상품",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            "모두보기",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget linecon() {
    return Divider(
      height: 20,
      color: Colors.grey[400],
      thickness: 0,
      endIndent: 15,
      indent: 15,
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(controller: _controller, slivers: [
      SliverList(
        delegate: SliverChildListDelegate([
          _makeSliderImage(),
          _sellerSimpleInfo(),
          linecon(),
          _contentText(),
          linecon(),
          otherContents()
        ]),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          delegate: SliverChildListDelegate(List.generate(
              20,
              (index) => Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey,
                            height: 120,
                          ),
                        ),
                        Text("상품제목", style: TextStyle(fontSize: 15)),
                        Text("가격",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15))
                      ],
                    ),
                  ))),
        ),
      )
    ]);
  }

  // void countSnackBar(BuildContext context, isMyFavoriteContent) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text(
  //       isMyFavoriteContent ? '상품에 좋아요를 하였습니다' : '상품에 좋아요를 취소 하였습니다',
  //       textAlign: TextAlign.center,
  //     ),
  //     duration: Duration(seconds: 1),
  //     backgroundColor: Colors.green[500],
  //   ));
  // }

  _bottomNavbar() {
    return Builder(
      builder: (context) {
        return Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          width: size.width,
          height: 55,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMyFavoriteContent = !isMyFavoriteContent;
                    // countSnackBar(context, isMyFavoriteContent);
                  });
                  scaffoldKey.currentState.showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 1000),
                    content: Text(isMyFavoriteContent
                        ? "상품에 좋아요를 했습니다"
                        : "상품에 좋아요를 취소 했습니다"),
                  ));
                },
                child: SvgPicture.asset(
                  isMyFavoriteContent
                      ? "assets/svg/heart_on.svg"
                      : "assets/svg/heart_off.svg",
                  width: 25,
                  height: 25,
                  color: Color(0xfff08f4f),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 10),
                height: 40,
                width: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 3),
                // color: Colors.red,
                child: Column(
                  children: [
                    Text(
                      widget.received["price"] + "원",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text('가격제안불가')
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      decoration: BoxDecoration(
                          color: Color(0xfff08f4f),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "채팅으로 거래하기",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavbar(),
    );
  }
}
