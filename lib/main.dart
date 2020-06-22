import 'dart:convert'; //! thư viện này dùng để import jsonDecode
import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; //! sử dụng thư viện http để gọi htt.get() lấy đường link file json
import 'episodes_page.dart';
import 'got.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), //! link tới HomePage StatefulWidget
      debugShowCheckedModeBanner: false, //! tắt icon debug trên màn hình app
      theme: ThemeData(primarySwatch: Colors.red), //! theme app change color
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() =>
      _HomePageState(); //! muốn sử dụng StatefulWidget thì phải có hàm State theo sau đó
}

class _HomePageState extends State<HomePage> {
  //! this is State giúp thay đổi state widget
  String url =
      "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes";
  //! link api

  Widget myCard() {
   
    return SingleChildScrollView(
      //! ScrollView giúp lướt màn hình lên xuống không bị tràn dữ liệu.
      child: Card(
         //! trong giao diện này, tất cả các giá trị sẽ nằm trong Card()
        child: Padding(
          padding: const EdgeInsets.all(18.0), 
          child: new Column(//! những values sẽ được nằm theo chiều từ trên xuống dưới
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Hero( //! hero giúp thực hiện animation
                tag: "g1", //! g1 là id để bắt sự kiện animation
                child: CircleAvatar( //! avatar sẽ được vẽ thành hình tròn 
                  radius: 100.0, //! giúp các góc cạnh thành hình tròn
                  backgroundImage: NetworkImage(got.image.original), //! lấy image từ đường link api
                ),
              ),
              SizedBox( //! tawgng khoảng cách chiều cao. giúp tăng khoảng cách của image with text
                height: 20.0,
              ),
              new Text( //! lấy name
                got.name,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(
                height: 20.0,
              ),
              new Text(//! lấy time
                "Run Time ${got.runtime.toString()}",
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 20.0,
              ),
              new Text( //! lấy summary
                got.summary,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              RaisedButton( //! nút button đùng để di chuyển tới page detail
                color: Colors.red,
                onPressed: () { //! bắt sự kiện khi người dùng click sẽ được chuyển tới page Detail
                  Navigator.push( 
                      context,
                      MaterialPageRoute(
                          builder: (context) => EpisodesPage( //! nextPage
                                //todo: 2 tham số sẽ được gửi sang. gồm có image and information
                                episodes: got.eEmbedded.episodes, //! data info
                                myImage: got.image, //! data image
                              )));
                },
                child: Text( //! Text of button
                  "All Episodes",
                  style: TextStyle(color: Colors.white), // font chữ có màu trắng.
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GOT got;
  Widget myBody() {
    //! got là dữ liệu được truyền ở trong sau khi gán file json (2)
    //! nếu có dữ liệu thì đi tới myCard()
    return got == null ? Center(child: CircularProgressIndicator()) : myCard();
  }

  @override
  void initState() {
    //! initState hiện ra 1 lần duy nhất khi chạy app
    super.initState();
    fetchEpisodes(); //! giúp lấy các giá trị và thay đổi các giá trị
  }

  fetchEpisodes() async {
    //! sử dụng async giúp phản hồi 1 cách tốt hơn.
    var res = await http.get(url); //! http lấy link api
    var decodedRes =
        jsonDecode(res.body); //! sau đó convert lại thành đường dẫn json
    print(decodedRes);
    got = GOT.fromJson(
        decodedRes); //! truyền file json vào got để đọc và trả lời (1)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Game Of Thrones"),
      ),
      body: myBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.refresh),
      ),
    );
  }
}
