import 'package:CarrotMarketClone/repository/contents_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'detailPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ContentsRepository contentsRepository;

  String currentLocation;
  final Map<String, String> locationCurrent = {
    "sinsa": "신사동",
    "nonhy": "논현동",
    "yuksa": "역삼동"
  };

  void initState() {
    super.initState();
    currentLocation = "sinsa";
    contentsRepository = ContentsRepository();
    print(contentsRepository.data);
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

  _loadContents() {
    return contentsRepository.loadContentsFromLocation(currentLocation);
  }

  _makeDataList(List<Map<String, String>> datas) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(datas[index]);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail(received: datas[index])));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Hero(
                        tag: datas[index]["cid"],
                        child: Image.asset(
                          datas[index]["image"],
                          height: 100,
                          width: 100,
                        ),
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
                            stringDetector(datas[index]["price"]),
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
        itemCount: datas.length);
  }

  stringDetector(String priceString) {
    if (priceString == "무료나눔") {
      return priceString;
    } else
      return priceString + "원";
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadContents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('데이터 오류'),
          );
        }

        if (snapshot.hasData) {
          return _makeDataList(snapshot.data);
        }

        return Center(
          child: Text("해당지역에 데이터 없음"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarwd(),
      body: Container(child: _bodyWidget()),
    );
  }
}
