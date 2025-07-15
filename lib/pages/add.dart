import 'package:finance/cubit/addCubit/add_data_cubit.dart';
import 'package:finance/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:finance/models/finance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class AddPage extends StatefulWidget {
  bool isPlus;
  FinanceModel? financeModel;
  AddPage({super.key, required this.isPlus, this.financeModel});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  TextEditingController detailsCon = TextEditingController();
  String num = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.financeModel != null) {
      setState(() {
        detailsCon.text = widget.financeModel!.details;
        num = widget.financeModel!.financeValue.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isPlus ? "Plus" : "Minus")),
      body: BlocProvider(
        create: (context) => AddDataCubit(),
        child: BlocBuilder<AddDataCubit, AddDataState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.purple[200],
                      ),
                      child: Center(
                        child: TextField(
                          controller: detailsCon,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            border: InputBorder.none,
                            hintText: "Details here...",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: widget.isPlus
                            ? Colors.green[200]
                            : Colors.red[300],
                      ),
                      child: Center(
                        child: Text(
                          widget.isPlus
                              ? (num == "" ? num = "+0.0" : num)
                              : (num == "" ? num = "-0.0" : num),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: widget.isPlus
                                ? Colors.green[900]
                                : Colors.red[900],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KeyPadItem(
                        number: "7",
                        onTap: () {
                          setState(() {
                            widget.isPlus
                                ? (num == "+0.0"
                                      ? num = "+" + "7"
                                      : num = num + "7")
                                : (num == "-0.0"
                                      ? num = "-" + "7"
                                      : num = num + "7");
                          });
                        },
                      ),
                      KeyPadItem(
                        number: "8",
                        onTap: () {
                          setState(() {
                            widget.isPlus
                                ? (num == "+0.0"
                                      ? num = "+" + "8"
                                      : num = num + "8")
                                : (num == "-0.0"
                                      ? num = "-" + "8"
                                      : num = num + "8");
                          });
                        },
                      ),
                      KeyPadItem(
                        number: "9",
                        onTap: () {
                          setState(() {
                            widget.isPlus
                                ? (num == "+0.0"
                                      ? num = "+" + "9"
                                      : num = num + "9")
                                : (num == "-0.0"
                                      ? num = "-" + "9"
                                      : num = num + "9");
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KeyPadItem(
                        number: "4",
                        onTap: () {
                          setState(() {
                            widget.isPlus
                                ? (num == "+0.0"
                                      ? num = "+" + "4"
                                      : num = num + "4")
                                : (num == "-0.0"
                                      ? num = "-" + "4"
                                      : num = num + "4");
                          });
                        },
                      ),
                      KeyPadItem(
                        number: "5",
                        onTap: () {
                          setState(() {
                            widget.isPlus
                                ? (num == "+0.0"
                                      ? num = "+" + "5"
                                      : num = num + "5")
                                : (num == "-0.0"
                                      ? num = "-" + "5"
                                      : num = num + "5");
                          });
                        },
                      ),
                      KeyPadItem(
                        number: "6",
                        onTap: () {
                          setState(() {
                            widget.isPlus
                                ? (num == "+0.0"
                                      ? num = "+" + "6"
                                      : num = num + "6")
                                : (num == "-0.0"
                                      ? num = "-" + "6"
                                      : num = num + "6");
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KeyPadItem(
                        number: "1",
                        onTap: () {
                          setState(() {
                            widget.isPlus
                                ? (num == "+0.0"
                                      ? num = "+" + "1"
                                      : num = num + "1")
                                : (num == "-0.0"
                                      ? num = "-" + "1"
                                      : num = num + "1");
                          });
                        },
                      ),
                      KeyPadItem(
                        number: "2",
                        onTap: () {
                          setState(() {
                            widget.isPlus
                                ? (num == "+0.0"
                                      ? num = "+" + "2"
                                      : num = num + "2")
                                : (num == "-0.0"
                                      ? num = "-" + "2"
                                      : num = num + "2");
                          });
                        },
                      ),
                      KeyPadItem(
                        number: "3",
                        onTap: () {
                          setState(() {
                            widget.isPlus
                                ? (num == "+0.0"
                                      ? num = "+" + "3"
                                      : num = num + "3")
                                : (num == "-0.0"
                                      ? num = "-" + "3"
                                      : num = num + "3");
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KeyPadItem(
                        number: ".",
                        onTap: () {
                          setState(() {
                            num.contains(".") ? null : num = num + ".";
                          });
                        },
                      ),
                      KeyPadItem(
                        number: "0",
                        onTap: () {
                          setState(() {
                            num = num + "0";
                          });
                        },
                      ),
                      KeyPadItem(
                        number: "<",
                        onTap: () {
                          setState(() {
                            widget.isPlus
                                ? (num == "+0.0"
                                      ? null
                                      : num = num.substring(0, num.length - 1))
                                : (num == "-0.0"
                                      ? null
                                      : num = num.substring(0, num.length - 1));
                          });
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            try {
                              if(widget.financeModel != null) {
                                widget.financeModel!.details = detailsCon.text;
                                widget.financeModel!.financeValue = double.parse(num);
                                widget.financeModel!.save(); 
                              } else {
                                BlocProvider.of<AddDataCubit>(context).addData(
                                FinanceModel(
                                  details: detailsCon.text,
                                  financeValue: double.parse(num),
                                  date: DateTime.now(),
                                ),
                              );
                              }
                              BlocProvider.of<FetchDataCubit>(context).fetchData();
                              BlocProvider.of<FetchDataCubit>(context).fetchDateData(dateTime: BlocProvider.of<FetchDataCubit>(context).sel);
                              Navigator.pop(context);
                            } on Exception catch (e) {
                              // TODO
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(24),
                            backgroundColor: Colors.blue[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text( widget.financeModel != null ?
                            "SAVE" : "ADD",
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(24),
                            backgroundColor: Colors.deepOrange[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.orange[900]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class KeyPadItem extends StatelessWidget {
  final String number;
  final Function()? onTap;
  KeyPadItem({super.key, required this.number, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: Center(
              child: Text(number, style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
