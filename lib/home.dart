import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> datas = [];
  String currentLocation;
  final Map<String, String> locationCurrent = {
    "sinsa": "신사동",
    "nonhy": "논현동",
    "yuksa": "역삼동"
  };

  void initState() {
    super.initState();
    currentLocation = "sinsa";
    datas = [
      {
        "cid": "1",
        "image": "assets/images/ara-1.jpg",
        "title": "네메시스 축구화275",
        "location": "제주 제주시 신사동",
        "price": "30000",
        "likes": "2"
      },
      {
        "cid": "2",
        "image": "assets/images/ara-2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "location": "제주 제주시 신사동",
        "price": "100000",
        "likes": "5"
      },
      {
        "cid": "3",
        "image": "assets/images/ara-3.jpg",
        "title": "치약팝니다",
        "location": "제주 제주시 신사동",
        "price": "5000",
        "likes": "0"
      },
      {
        "cid": "4",
        "image": "assets/images/ara-4.jpg",
        "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
        "location": "제주 제주시 논현동",
        "price": "2500000",
        "likes": "6"
      },
      {
        "cid": "5",
        "image": "assets/images/ara-5.jpg",
        "title": "디월트존기임팩",
        "location": "제주 제주시 논현동",
        "price": "150000",
        "likes": "2"
      },
      {
        "cid": "6",
        "image": "assets/images/ara-6.jpg",
        "title": "갤럭시s10",
        "location": "제주 제주시 논현동",
        "price": "180000",
        "likes": "2"
      },
      {
        "cid": "7",
        "image": "assets/images/ara-7.jpg",
        "title": "선반",
        "location": "제주 제주시 역삼동",
        "price": "15000",
        "likes": "2"
      },
      {
        "cid": "8",
        "image": "assets/images/ara-8.jpg",
        "title": "냉장 쇼케이스",
        "location": "제주 제주시 역삼동",
        "price": "80000",
        "likes": "3"
      },
      {
        "cid": "9",
        "image": "assets/images/ara-9.jpg",
        "title": "대우 미니냉장고",
        "location": "제주 제주시 역삼동",
        "price": "30000",
        "likes": "3"
      },
      {
        "cid": "10",
        "image": "assets/images/ara-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "location": "제주 제주시 아라동",
        "price": "50000",
        "likes": "7"
      },
    ];
  }

  Widget _appbarwd() {
    return AppBar(
      elevation: 1,
      title: GestureDetector(
        onTap: () {
          print('left click');
        },
        child: PopupMenuButton<String>(
          offset: Offset(0, 20),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              1),
          onSelected: (String where) {
            print(where);
            setState(() {
              currentLocation = where;
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: "sinsa",
                child: Text("신사동"),
              ),
              PopupMenuItem(
                value: "nonhy",
                child: Text("논현동"),
              ),
              PopupMenuItem(
                value: "yuksa",
                child: Text("역삼동"),
              )
            ];
          },
          child: Row(
            children: [
              
              Text(locationCurrent[currentLocation]),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.tune,
              color: Colors.black,
            ),
            onPressed: () {}),
        IconButton(
            icon: SvgPicture.asset(
              "assets/svg/bell.svg",
              color: Colors.black,
              height: 25,
              width: 25,
            ),
            onPressed: () {})
      ],
    );
  }

  Widget _bodyWidget() {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.asset(
                      datas[index]["image"],
                      height: 100,
                      width: 100,
                    )),
                Expanded(
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datas[index]["title"],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          datas[index]["location"],
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.4)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          datas[index]["price"] + "원",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/heart_off.svg",
                                  height: 25,
                                  width: 15,
                                ),
                                Text(datas[index]["likes"])
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: ((context, index) {
          return Divider(
            height: 10,
            color: Colors.grey[700],
            thickness: 0,
          );
        }),
        itemCount: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarwd(),
      body: Container(child: _bodyWidget()),
    );
  }
}
