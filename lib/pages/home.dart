import 'package:finance/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:finance/models/finance_model.dart';
import 'package:finance/pages/add.dart';
import 'package:finance/pages/see_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchDataCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box("darkModeBox").listenable(),
      builder: (context, box, child) {
      var darkMode = box.get('darkMode', defaultValue: false);
      return Scaffold(
        appBar: AppBar(
          title: Text("Welcome YAHIAOUI Mohammed El AMine"),
          actions: [
            IconButton(
              onPressed: () {
                box.put('darkMode', !darkMode);
              }, 
              icon: Icon(!darkMode
                ? Icons.brightness_2_rounded : Icons.brightness_5_rounded,
              ),
              ),
            ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    DrawerHeader(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Text(
                              "Y"
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "YAHIAOUI Mohammed El Amine",
                          ),
                        ],
                      ),
                      ),
                      ListTile(
                        title: Text(
                          "Dark Mode"
                        ),
                        trailing: Switch(
                          value: darkMode, 
                          onChanged: (value) {
                            box.put('darkMode', !darkMode);
                          },
                          ),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAll(),));
                        },
                        title: Text(
                          "All Activities",
                        ),
                        trailing: Icon(
                          Icons.local_activity_outlined,
                        ),
                      ),
                      ListTile(
                        onTap: () => Navigator.pop(context),
                        title: Text(
                          "Close Drawer",
                        ),
                        trailing: Icon(
                          Icons.close,
                        ),
                      ),
                  ],
                ),
              ),
              ListTile(
                onTap: () => SystemNavigator.pop(),
                title: Text(
                  "Exit App",
                ),
                trailing: Icon(
                  Icons.exit_to_app,
                ),
              )
            ],
          ),
        ),
        body: BlocBuilder<FetchDataCubit, FetchDataState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: state is FetchDataLoading ? Column(
                children: [
                  Center(child: 
                  CircularProgressIndicator(),
                  ),
                ],
              ) : Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                              ),
                              color: Colors.black,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "My Balance",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  NumberFormat.compactCurrency(
                                    decimalDigits: 2,
                                    symbol: "DZD ")
                                    .format(BlocProvider.of<FetchDataCubit>(context).sum),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[100],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    ),
                  SizedBox(
                    height: 120,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Today",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  BlocProvider.of<FetchDataCubit>(context).sum.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.pink[100],
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPage(isPlus: true),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green[100],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add, color: Colors.green),
                                Text("Plus"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                        ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPage(isPlus: false),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.red[100],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                Text("Minus"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text("Activity", style: TextStyle(fontSize: 18)),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SeeAll()),
                          );
                        },
                        child: Text("See all", style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: BlocProvider.of<FetchDataCubit>(context).todayFinanceList.length,
                      itemBuilder: (context, index) {
                        List<FinanceModel> mylist = BlocProvider.of<FetchDataCubit>(context).todayFinanceList.reversed.toList();
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Dismissible(
                            background: Container(
                              decoration: BoxDecoration(
                                color: Colors.green[200],
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            secondaryBackground:  Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent[200],
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => AddPage(
                                        isPlus: mylist[index].financeValue > 0 ? true : false,
                                        financeModel: mylist[index],
                                          ),
                                        ),
                                      );
                                    } else if (direction == DismissDirection.endToStart) {
                                      mylist[index].delete();
                                      BlocProvider.of<FetchDataCubit>(context).fetchData();
                                    }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: mylist[index].financeValue > 0 ? Colors.green :  Colors.redAccent),
                                  SizedBox(
                                    width: 15
                                    ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mylist[index].details.toString(),
                                        ),
                                      Text(
                                        DateFormat.yMMMEd().format(mylist[index].date),
                                        ),
                                    ],
                                  ),
                                  Spacer(),
                                   mylist[index].financeValue > 0 ? Text("+") : Text(""),
                                  Text(
                                    mylist[index].financeValue.toString(),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
      }
    );
  }
}
