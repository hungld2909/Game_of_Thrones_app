import 'package:Game_of_Thrones_app/got.dart';
import 'package:flutter/material.dart';

class EpisodesPage extends StatelessWidget {
  List<Episodes> episodes;
  //todo: nhận dữ liệu bên này trước xog sang bên kia mới truyền dữ liệu sau.
  MyImage myImage; //! nhận data
  EpisodesPage({this.episodes, this.myImage}); //! constructor
  BuildContext _context;
  showSummary(String summary) {
    //! dùng để show Dialog
    showDialog(
        context:
            _context, //! _context này được hiểu rằng. khai báo từ BuildContext. BuildContext được dùng để create widget.
        builder: (context) => Center( //! context sẽ được hiện thị ở giữa màn hình.
              child: Padding(
                padding: const EdgeInsets.all(12.0), //! khoảng cách giữa các lề là 12
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      summary, //! hiện thị data vào text.
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget myBody() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //! hiện thị số lượng GridView trên màn hình.
          childAspectRatio:
              1.0), //! childAspectTatio là tỉ lệ cách nhau giữa các ô trong GridView
      itemBuilder: (context, index) => InkWell( //! bắt sự kiện khi click vào item trong GridView
        onTap: () {
          showSummary(episodes[index].summary); //! showDiaLog
        },
        child: Card( //! trong GridView thì hiện thị Card.
          child: Stack( //! trong Card hiện thị Image,text thì phải sử dụng stack
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(
                episodes[index].image.original, //! lấy ảnh theo từng vị trí index
                fit: BoxFit.cover, //! convert sao cho a vừa với ô Card
                //! need information of it
                //? color: Colors.black,
                //?colorBlendMode: BlendMode.darken,
                // colorBlendMode: BlendMode.darken, //todo: giúp thay đổi màu trong image. giống kiểu chụp ảnh xong chỉnh sửa màu ảnh
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      episodes[index].name, //! hiện thị Name ở dưới hình ảnh nằm ở dưới Card
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "${episodes[index].season}-${episodes[index].number}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
      itemCount: episodes.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: new AppBar(
        title: Row(
          children: <Widget>[
            Hero( //! bắt sự kiện animation
              tag: "g1", //! g1 lấy từ key từ màn hình trước đó. để biết cái nào đang được gọi
              child: CircleAvatar( //! avatar sẽ được bắt sự kiện animation
                backgroundImage: NetworkImage( 
                  myImage.medium, //! data image 
                ),
              ),
            ),
            SizedBox( //! khoảng cách width với image là 10
              width: 10.0,
            ),
            Text("All Episodes") 
          ],
        ),
      ),
      body: myBody(),
    );
  }
}
