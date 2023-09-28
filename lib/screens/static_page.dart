import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shift_calendar/screens/home_page.dart';

class StaticPage extends StatefulWidget {
  const StaticPage({Key? key, required this.events, required this.static_list}) : super(key: key);
  final events;
  final static_list;
  @override
  State<StaticPage> createState() => _StaticPageState();
}

class _StaticPageState extends State<StaticPage> {
  var f = NumberFormat('###,###,###,###');
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기록'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFEFAF8),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/chunsik_bg_3.jpg'), // 배경 이미지
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.static_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.static_list[index][0].toString().substring(0,4) + '년 ' + widget.static_list[index][0].toString().substring(5) + '월',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                '출근일 : ' + f.format(widget.static_list[index][1])+ '日',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '월급 : ' + f.format(widget.static_list[index][2])+ '円',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '교통비 : ' + f.format(widget.static_list[index][1]*776)+ '円',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                '합계 : ' + f.format(widget.static_list[index][2] + widget.static_list[index][1]*776)+ '円',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffFEFAF8),
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
        selectedItemColor: const Color(0xFFF48FB1),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 14),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(_currentIndex == 0 ? Icons.calendar_month : Icons.calendar_month_outlined), label: '달력'),
          BottomNavigationBarItem(icon: Icon(_currentIndex == 1 ? Icons.insert_chart : Icons.insert_chart_outlined), label: '기록'),
        ],
        onTap: (int index){
          setState(() {
            _currentIndex = index;
            if(index == 0){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => HomePage(get_events: widget.events, get_stats: widget.static_list)), (route) => false);
            }
            if(index == 1) null;
          });
        },
      ),
    );
  }
}
