import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shift_calendar/screens/loading_page.dart';
import 'package:shift_calendar/screens/static_page.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.get_events, required this.get_stats}) : super(key: key);
  final get_events;
  final get_stats;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> _boolean = [false, false];
  bool exist_check = false;
  ///일급 추가 버튼 동작 함수
  ///일급 계산 방식을 고르게 함
  void add_dialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Color(0xffFEFAF8),
            child: Container(
                width: 150,
                height: 150,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '방 개수 계산 / 일한 시간 계산',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          children: <Widget>[
                            Icon(Icons.bedroom_child_outlined, size: 64,),
                            Icon(Icons.more_time_rounded, size: 64,),
                          ],
                          onPressed: (int index) {
                            if (index == 0) {
                              Navigator.pop(context);
                              add_by_room();
                            }
                            else {
                              Navigator.pop(context);
                              add_by_time();
                            }
                          },
                          isSelected: _boolean,
                        ),
                      ],
                    ),
                  ],
                )),
          );
        }
    );
  }

  ///방 숫자로 급여를 추가하는 함수
  void add_by_room() {
    num room_one = 0;
    num room_two = 0;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Color(0xffFEFAF8),
          child: Container(
              width: 150,
              height: 250,
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '방 기록 추가',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      room_one = num.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '풀 청소 방 개수',
                    ),
                  ),
                  TextFormField(
                    onChanged: (value2) {
                      room_two = num.parse(value2);
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '간단 청소 방 개수',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () async {
                            var prefs = await SharedPreferences.getInstance();
                            String? decode_event = prefs.getString('events');
                            Map<String, dynamic> temp_events = json.decode(decode_event!);
                            String utc_year = year.toString();
                            String utc_month = month.toString();
                            utc_month.length == 1 ? utc_month = '0' + utc_month : utc_month = month.toString();
                            String utc_day = day.toString();
                            utc_day.length == 1 ? utc_day = '0' + utc_day : utc_day = day.toString();

                            String utc_temp = utc_year+utc_month+utc_day;
                            String utc_idx = utc_year+utc_month;

                            temp_events[utc_temp] = [room_one, room_two, 0, num.parse(utc_idx)];
                            String encode_event = json.encode(temp_events);
                            prefs.setString('events', encode_event);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => LoadingPage()), (route) => false);
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
    );
  }
  ///일한 시간으로 급여를 추가하는 함수
  void add_by_time() {
    num work_time = 0;
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
                height: 200,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '시간 기록 추가',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '일한 시간',
                      ),
                      onChanged: (value3) {
                        work_time = num.parse(value3);
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () async {
                              var prefs = await SharedPreferences.getInstance();
                              String? decode_event = prefs.getString('events');
                              Map<String, dynamic> temp_events = json.decode(decode_event!);
                              String utc_year = year.toString();
                              String utc_month = month.toString();
                              utc_month.length == 1 ? utc_month = '0' + utc_month : null;
                              String utc_day = day.toString();
                              utc_day.length == 1 ? utc_day = '0' + utc_day : null;

                              String utc_temp = utc_year+utc_month+utc_day;
                              String utc_idx = utc_year+utc_month;

                              temp_events[utc_temp] = [0, 0, work_time, num.parse(utc_idx)];
                              String encode_event = json.encode(temp_events);
                              prefs.setString('events', encode_event);
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => LoadingPage()), (route) => false);
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
    );
  }
  ///일한 내역을 지우는 함수
  void delete_work() {
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
                height: 200,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '진짜 지울꺼야?',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () async {
                              var prefs = await SharedPreferences.getInstance();
                              String? decode_event = prefs.getString('events');
                              Map<String, dynamic> temp_events = json.decode(decode_event!);
                              String utc_year = year.toString();
                              String utc_month = month.toString();
                              utc_month.length == 1 ? utc_month = '0' + utc_month : null;
                              String utc_day = day.toString();
                              utc_day.length == 1 ? utc_day = '0' + utc_day : null;
                              String utc_temp = utc_year+utc_month+utc_day;
                              temp_events.remove(utc_temp);
                              String encode_event = json.encode(temp_events);
                              prefs.setString('events', encode_event);
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => LoadingPage()), (route) => false);
                            },
                            child: const Text("지우기"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100,40),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
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
    );
  }
  var f = NumberFormat('###,###,###,###');
  Map<DateTime, List<dynamic>> events = {};
  List<List<num>> statics_list = [];
  List<dynamic> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
  int _currentIndex = 0;
  late num num_large;
  late num num_small;
  late num money;
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  bool check_select = false;
  DateTime focusedDay = DateTime.now();
  late int year;
  late int month;
  late int day;

  ///매달 기록을 정렬하는 함수
  ///0번째 원소를 기준으로 내림차순 정렬
  void sort_list() {
    int len_list = statics_list.length;
    for (int i=0; i<len_list; i++) {
      for (int j=i+1; j<len_list; j++) {
        if (statics_list[i][0] < statics_list[j][0]) {
          var save_temp = statics_list[i];
          statics_list[i] = statics_list[j];
          statics_list[j] = save_temp;
        }
      }
    }
  }
  @override
  void initState() {
    events = widget.get_events;
    statics_list = widget.get_stats;
    sort_list();
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
      money = _getEventsForDay(DateTime.utc(year, month, day))[2]*1100;
      exist_check = true;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('달력'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFEFAF8),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/chunsik_bg_4.jpg'), // 배경 이미지
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
                          year = int.parse(selectedDay.toString().substring(0,4));
                          month = int.parse(selectedDay.toString().substring(5,7));
                          day = int.parse(selectedDay.toString().substring(8,10));
                          //print(year);
                          //print(month);
                          //print(day);
                          if ( _getEventsForDay(DateTime.utc(year, month, day)).length == 0) {
                            num_large = -65535;
                            num_small = -65535;
                            money = -65535;
                            exist_check = false;
                          }
                          else {
                            num_large = _getEventsForDay(DateTime.utc(year, month, day))[0];
                            num_small = _getEventsForDay(DateTime.utc(year, month, day))[1];
                            money = _getEventsForDay(DateTime.utc(year, month, day))[2]*1100;
                            exist_check = true;
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
                              num_large == -65535 ? '' : '일급 : ' + f.format(num_large * 650 + num_small * 160) + '엔',
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
                            money % 1100 == 0 ? '일한 시간 : ${(money / 1100).toInt()}시간' :
                            '일한 시간 : ${(money / 1100)}시간',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            '일급 : ' + f.format(money) + '엔',
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
                      icon: Icons.settings,
                      children: [
                        exist_check == false ?
                        SpeedDialChild(
                          child: Icon(Icons.add),
                          onTap: () => add_dialog(),
                        ) :
                        SpeedDialChild(
                          child: Icon(Icons.delete),
                          onTap: () => delete_work(),
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
            if(index == 0) null;
            if(index == 1) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => StaticPage(events: events, static_list: statics_list)), (route) => false);
            }
          });
        },
      ),
    );
  }
}
