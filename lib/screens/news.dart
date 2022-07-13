import 'package:flutter/material.dart';
import '../widgets/news_item.dart';

class NEWS extends StatelessWidget {
  const NEWS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const news = [
        {
          'image':  'assets/images/news1.jpg',
          'title' : 'कोरोना काल में अपने माता पिता को खो चुके बच्चों के साथ पप्पू पहलवान ने मनाई दीपावली',
          'url' :'https://www.himachalxpresstv.com/story/-26537.html',

        },
          {
          'image':  'assets/images/news2.jpg',
          'title' : 'बेटी बचाओ बेटी पढ़ाओ महिला सुरक्षा के नाम पर जानवरों से बदतर व्यवहार किया जा रहा: पप्पू पहलवान',
          'url' :'https://www.himachalxpresstv.com/story/-20468.html',

        },
          {
          'image':  'assets/images/news3.jpeg',
          'title' : 'प्रकाश राणा के नेतृत्व में विकास में पिछड़ा जोगिंदर नगर, नशे में सबसे आगेः पप्पू पहलवान',
          'url' :'https://www.etvbharat.com/hindi/himachal-pradesh/city/mandi/congress-leader-jeevan-thakur-press-conference-in-mandi/hp20220226180316249',

        },
          {
          'image':  'assets/images/chat_screen.jpg',
          'title' : 'प्रकाश राणा के नेतृत्व में विकास में पिछड़ा जोगिंदरनगर, नशे में सबसे आगेः पप्पू पहलवान',
          'url' :'https://www.livetimes.tv/hi/news/article/7751a367-498d-4a18-a22a-0098ce0392d0',

        },
    ];

   
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left:10,top: 10),
      child: Column(
        children: [
          Row(
              children: const [
                 Text(
                  'In the NEWS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  news.length,
                  (index) => NewsItem(
                        title: news[index]['title'],
                        image: news[index]['image'],
                        url: news[index]['url'],
                        comments: 20,
                        date: DateTime.now(),
                        likes: 178,
                        provider: 'NEWS UPDATE',
                        shares: 39,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
