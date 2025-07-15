import 'package:finance/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:finance/models/finance_model.dart';
import 'package:finance/pages/add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {

  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime mySelectedDay = DateTime.now();
  DateTime myFocusedDay = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchDataCubit>(context).fetchDateData(dateTime: mySelectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All activities")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<FetchDataCubit, FetchDataState>(
          builder: (context, state) {
            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime(2025),
                  lastDay: DateTime.now(),
                  focusedDay: myFocusedDay,
                  calendarFormat: calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                  currentDay: mySelectedDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      mySelectedDay = selectedDay;
                      myFocusedDay = focusedDay;
                      BlocProvider.of<FetchDataCubit>(context).sel = mySelectedDay;
                    });
                    BlocProvider.of<FetchDataCubit>(context).fetchDateData(dateTime: mySelectedDay);
                  },
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: BlocProvider.of<FetchDataCubit>(context).dateFinanceList.length,
                    itemBuilder: (context, index) {
                      List<FinanceModel> mylist = BlocProvider.of<FetchDataCubit>(context).dateFinanceList;
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Dismissible(
                          background: Container(
                            decoration: BoxDecoration(color: Colors.green[200]),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                          secondaryBackground: Container(
                            decoration: BoxDecoration(
                              color: Colors.redAccent[200],
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddPage(
                                    isPlus: mylist[index].financeValue > 0
                                        ? true
                                        : false,
                                    financeModel: mylist[index],
                                  ),
                                ),
                              );
                            } else if (direction ==
                                DismissDirection.endToStart) {
                              mylist[index].delete();
                              BlocProvider.of<FetchDataCubit>(
                                context,
                              ).fetchData();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      mylist[index].financeValue > 0
                                      ? Colors.green
                                      : Colors.redAccent,
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(mylist[index].details.toString()),
                                    Text(
                                      DateFormat.yMMMEd().format(
                                        mylist[index].date,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                mylist[index].financeValue > 0
                                    ? Text("+")
                                    : Text(""),
                                Text(mylist[index].financeValue.toString()),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
