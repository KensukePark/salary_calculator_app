import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:shift_calendar/screens/static_page.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void sort_list() {
    int len_list = statics_list.length;
    for (int i=0; i<len_list-1; i++) {
      for (int j=i+1; j<len_list-1; j++) {
        if (statics_list[i][0] < statics_list[j][0]) {
          var save_temp = statics_list[i];
          statics_list[i] = statics_list[j];
          statics_list[j] = save_temp;
        }
      }
    }
  }
  void add_dialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
              width: 150,
              height: 300,
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아르바이트 기록 추가',
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: _add_idx,
                              onChanged: (value) {
                                setState(() {
                                  _add_idx = 0;
                                });
                              },
                            ),
                            Expanded(
                              child: Text('방 계산'),
                            )
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _add_idx,
                              onChanged: (value) {
                                setState(() {
                                  _add_idx = 1;
                                });
                              },
                            ),
                            Expanded(
                              child: Text('시간 계산'),
                            )
                          ],
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                  _add_idx == 0 ?
                    Column(
                      children: [
                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: '풀 청소 방 개수',
                          ),
                        ),
                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: '간단 청소 방 개수',
                          ),
                        ),
                      ],
                    ) :
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '일한 시간',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            /// Navigator.pop에서 result값을 넣어주면
                            /// showDialog의 return 값이 됩니다.
                            /// return value
                            Navigator.pop(context);
                          },
                          child: const Text("추가"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100,40),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            /// Navigator.pop에서 result값을 넣어주면
                            /// showDialog의 return 값이 됩니다.
                            /// return value
                            Navigator.pop(context);
                          },
                          child: const Text("취소"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100,40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        );
      }
    ).then((value) {

    }).whenComplete(() {
      null;
    });
  }
  var f = NumberFormat('###,###,###,###');
  Map<DateTime, List<double>> events = {
    DateTime.utc(2023,6,20) : [ 0, 0, 4950],
    DateTime.utc(2023,6,21) : [ 0, 0, 4950],
    DateTime.utc(2023,6,22) : [ 0, 0, 4950 ],
    DateTime.utc(2023,6,28) : [ 0, 0, 4950 ],
    DateTime.utc(2023,6,29) : [ 0, 0, 4950 ],
    DateTime.utc(2023,6,30) : [ 0, 0, 6600 ],
    DateTime.utc(2023,7,1) : [ 0, 0, 5500],
    DateTime.utc(2023,7,2) : [ 0, 0, 9900],
    DateTime.utc(2023,7,4) : [ 0, 0, 3300],
    DateTime.utc(2023,7,5) : [ 0, 0, 4950],
    DateTime.utc(2023,7,8) : [ 0, 0, 9900],
    DateTime.utc(2023,7,9) : [ 17, 2, 0],
    DateTime.utc(2023,7,11) : [ 2, 19, 0],
    DateTime.utc(2023,7,13) : [ 0, 0, 10450],
    DateTime.utc(2023,7,15) : [ 11, 6, 0],
    DateTime.utc(2023,7,16) : [ 13, 4, 0],
    DateTime.utc(2023,7,18) : [ 15, 5, 0],
    DateTime.utc(2023,7,19) : [ 16, 0, 0],
    DateTime.utc(2023,7,21) : [ 10, 3, 0],
    DateTime.utc(2023,7,23) : [ 16, 0, 0],
    DateTime.utc(2023,7,24) : [ 15, 0, 0],
    DateTime.utc(2023,7,27) : [ 18, 1, 0],
    DateTime.utc(2023,8,3) : [ 10, 0, 0 ],
    DateTime.utc(2023,8,5) : [ 15, 3, 0 ],
    DateTime.utc(2023,8,6) : [ 17, 2, 0 ],
    DateTime.utc(2023,8,8) : [ 15, 5, 0 ],
    DateTime.utc(2023,8,9) : [ 11, 0, 0 ],
    DateTime.utc(2023,8,10) : [ 6, 6, 0 ],
    DateTime.utc(2023,8,11) : [ 13, 1, 0 ],
    DateTime.utc(2023,8,13) : [ 16, 5, 0 ],
    DateTime.utc(2023,8,14) : [ 21.5, 8, 0 ],
    DateTime.utc(2023,8,16) : [ 20, 1, 0 ],
    DateTime.utc(2023,8,17) : [ 13, 3, 0 ],
    DateTime.utc(2023,8,19) : [ 12, 3, 0 ],
    DateTime.utc(2023,8,21) : [ 9, 9 , 0],
    DateTime.utc(2023,8,22) : [ 12, 12, 0 ],
    DateTime.utc(2023,8,25) : [ 11, 6, 0 ],
    DateTime.utc(2023,8,27) : [ 18, 1, 0 ],
    DateTime.utc(2023,8,28) : [ 10, 2, 0 ],
    DateTime.utc(2023,8,31) : [ 13.5, 5, 0 ],
    DateTime.utc(2023,9,2) : [ 5, 2, 0 ],
    DateTime.utc(2023,9,3) : [ 16, 3, 0 ],
    DateTime.utc(2023,9,6) : [ 10, 10, 0 ],
    DateTime.utc(2023,9,7) : [ 14, 13, 0 ],
    DateTime.utc(2023,9,8) : [ 14, 14, 0 ],
    DateTime.utc(2023,9,10) : [ 17, 3, 0 ],
    DateTime.utc(2023,9,11) : [ 15, 6, 0 ],
    DateTime.utc(2023,9,13) : [ 8, 13, 0 ],
    DateTime.utc(2023,9,15) : [ 10, 19, 0 ],
    DateTime.utc(2023,9,16) : [ 28, 7, 0 ],
    DateTime.utc(2023,9,17) : [ 14, 2, 0 ],
    DateTime.utc(2023,9,26) : [ 14, 5, 0 ],
    DateTime.utc(2023,9,27) : [ 18, 0, 0 ],
    //DateTime.utc(2023,9,28) : [ 5, 2, 0],
  };
  List<double> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
  int _add_idx = 0;
  int _currentIndex = 0;
  late double num_large;
  late double num_small;
  late double money;
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  bool check_select = false;
  DateTime focusedDay = DateTime.now();
  List<List<int>> statics_list = [[202309, 13, 134470], [202308,18,169470]];
  Map<String, List<int>> statics = {
    '202308' : [18, 169470],
    '202309' : [13, 134470]
  };
  late int year;
  late int month;
  late int day;
  @override
  void initState() {
    super.initState();
    year = int.parse(selectedDay.toString().substring(0,4));
    month = int.parse(selectedDay.toString().substring(5,7));
    day = int.parse(selectedDay.toString().substring(8,10));
    if ( _getEventsForDay(DateTime.utc(year, month, day)).length == 0) {
      num_large = -65535;
      num_small = -65535;
      money = -65535;
    }
    else {
      num_large = _getEventsForDay(DateTime.utc(year, month, day))[0];
      num_small = _getEventsForDay(DateTime.utc(year, month, day))[1];
      money = _getEventsForDay(DateTime.utc(year, month, day))[2];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('달력'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFEFAF8),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/chunsik_bg_3.jpg'), // 배경 이미지
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    TableCalendar(
                      locale: 'ko_KR',
                      firstDay: DateTime.utc(1900, 1, 1),
                      lastDay: DateTime.utc(2037, 12, 31),
                      focusedDay: focusedDay,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      eventLoader: _getEventsForDay,
                      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                        setState((){
                          check_select = true;
                          this.selectedDay = selectedDay;
                          this.focusedDay = focusedDay;
                          int year = int.parse(selectedDay.toString().substring(0,4));
                          int month = int.parse(selectedDay.toString().substring(5,7));
                          int day = int.parse(selectedDay.toString().substring(8,10));
                          if ( _getEventsForDay(DateTime.utc(year, month, day)).length == 0) {
                            num_large = -65535;
                            num_small = -65535;
                            money = -65535;
                          }
                          else {
                            num_large = _getEventsForDay(DateTime.utc(year, month, day))[0];
                            num_small = _getEventsForDay(DateTime.utc(year, month, day))[1];
                            money = _getEventsForDay(DateTime.utc(year, month, day))[2];
                          }
                        });
                      },
                      selectedDayPredicate: (DateTime day) {
                        return isSameDay(selectedDay, day);
                      },
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible : false,
                        isTodayHighlighted : false,
                        rangeStartDecoration: BoxDecoration(
                          color : const Color(0xFFF48FB1),
                          shape: BoxShape.circle,
                        ),
                        rangeEndDecoration: BoxDecoration(
                          color: const Color(0xFFF48FB1),
                          shape: BoxShape.circle,
                        ),
                        rangeHighlightColor: const Color(0xFFF48FB1),
                        todayDecoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration : const BoxDecoration(
                          color: const Color.fromRGBO(163, 122, 68, 109),
                          shape: BoxShape.circle,
                        ),
                        markerSizeScale : 0.7,
                        markersMaxCount: 1,
                        markerDecoration : const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/chunsik_icon.png'),
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
            Container(
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 24,
                      child: Center(
                        child: Text(
                          selectedDay.toString().substring(0,4) + '년 ' + selectedDay.toString().substring(5,7) + '월 ' + selectedDay.toString().substring(8,10) + '일',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    (money == 0 || money == -65535) ?
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              num_large == -65535 ? '' : (num_large != 0 && num_large % 1 == 0) ? '풀로 청소한 방 수 : ${num_large.toInt()}' : '풀로 청소한 방 수 : ${num_large}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text(
                              num_large == -65535 ? '' : (num_large != 0 && num_small % 1 == 0) ? '간단하게 청소한 방 수 : ${num_small.toInt()}' : '풀로 청소한 방 수 : ${num_small}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text(
                              num_large == -65535 ? '' : '일급 : ' + f.format(num_large * 650 + num_small * 160) + '円',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      )
                    :
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '일한 시간 : ${(money / 1100).toInt()}시간',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            '일급 : ' + f.format(money) + '円',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SpeedDial(
                      backgroundColor: const Color.fromRGBO(163, 122, 68, 109),
                      icon: Icons.add,
                      children: [
                        SpeedDialChild(
                          child: Icon(Icons.add),
                          onTap: () => add_dialog(),
                        ),
                        SpeedDialChild(
                          child: Icon(Icons.create_outlined),
                          onTap: () => null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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
            }
            if(index == 1){
              Navigator.push(context, MaterialPageRoute (builder: (BuildContext context) => StaticPage(static_list: statics_list)));
            }
          });
        },
      ),
    );
  }
}
