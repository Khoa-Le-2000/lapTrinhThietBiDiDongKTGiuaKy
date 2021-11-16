import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lap_trinh_di_dong_kiem_tra/ViewWeb.dart';
import 'package:lap_trinh_di_dong_kiem_tra/news.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  static const URL_1 = "https://newsapi.org/v2/everything?q=tesla&from=2021-10-16&sortBy=publishedAt&apiKey=d2d82c106db743b98cb9ca340ad30ea5";
  static const URL_2 = "https://newsapi.org/v2/everything?q=running&from=2021-10-16&sortBy=publishedAt&apiKey=d2d82c106db743b98cb9ca340ad30ea5";
  static const URL_3 = "https://newsapi.org/v2/everything?q=love&from=2021-10-16&sortBy=publishedAt&apiKey=d2d82c106db743b98cb9ca340ad30ea5";
  static const URL_4 = "https://newsapi.org/v2/everything?q=traveling&from=2021-10-16&sortBy=publishedAt&apiKey=d2d82c106db743b98cb9ca340ad30ea5";

  late Future<News> news;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    news = News.fecthData(URL_1);
  }

  void reload(String url){
    news = News.fecthData(url);
  }

  List<Widget> listCarousel() {
    List<Widget> lsWidget = [];

    lsWidget.add(
      Container(
        height: 100,
        child: InkWell(
          onTap: (){
            setState(() {
              reload(URL_1);
            });
          },
          child: Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://photo-zmp3.zadn.vn/cover/b/1/e/b/b1eb8ae84392957f9b9d1ce2bb42aab9.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Business",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    lsWidget.add(
      Container(
        height: 100,
        child: InkWell(
          onTap: (){
            setState(() {
              reload(URL_2);
            });
          },
          child: Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "https://photo-zmp3.zadn.vn/cover/8/5/d/1/85d1cfedf63d33e676e85071ab023f66.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Running",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    lsWidget.add(
      Container(
        height: 100,
        child: InkWell(
          onTap: (){
            setState(() {
              reload(URL_3);
            });
          },
          child: Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "https://photo-zmp3.zadn.vn/cover/0/a/e/f/0aef849d584c7e995073617f53b9ac24.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Love",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    lsWidget.add(
      Container(
        height: 100,
        child: InkWell(
          onTap: (){
            setState(() {
              reload(URL_4);
            });
          },
          child: Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://photo-zmp3.zadn.vn/cover/2/e/9/6/2e966bf47b1989fdff7149c7a1b0f25e.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Traveling",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return lsWidget;
  }

  Widget carousel() {
    return Container(
      child: CarouselSlider (
        items: listCarousel(),
        options: CarouselOptions(
          height: 75,
          viewportFraction: 0.44,
        ),
      ),
    );
  }

  Widget newsWidget() {
    return Container(
      height: double.maxFinite,
      child: FutureBuilder(
        future: news,
        builder: (BuildContext context, AsyncSnapshot<News> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as News;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data.articles.length,
              itemBuilder: (BuildContext context, int index) {
                Article article = data.articles[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewPage(url: article.url)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              article.urlToImage??"",
                              width: 500,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            article.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(article.description),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "KL NEWS",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: carousel(),
            ),
            Expanded(
              child: newsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
