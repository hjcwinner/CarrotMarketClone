import 'package:CarrotMarketClone/app.dart';
import 'package:CarrotMarketClone/repository/contents_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'detailPage.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  ContentsRepository contentsRepository;

  @override
  void initState(){
    super.initState();

    contentsRepository = ContentsRepository();
  }

  Widget _appbarwd() {
    return AppBar(title: Text("Favorite"));
  }

  _makeDataList(List<dynamic> datas) {
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

  Future<List<dynamic>> _loadMyFavoriteContents()async{
return await contentsRepository.loadFavoriteContents();
  }

  
  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadMyFavoriteContents(),
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
