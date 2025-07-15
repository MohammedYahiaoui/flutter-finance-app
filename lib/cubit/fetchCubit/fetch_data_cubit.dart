import 'package:bloc/bloc.dart';
import 'package:finance/models/finance_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());
  
  List<FinanceModel> finanaceList = [];
  List<FinanceModel> todayFinanceList = [];
  List<FinanceModel> dateFinanceList = [];
  double sum = 0.0;
  double todaySum = 0.0;
   DateTime sel = DateTime.now();

  fetchData() {
    emit(FetchDataLoading());
    try {
  finanaceList = Hive.box<FinanceModel>("financeBox").values.toList();
  todayFinanceList = finanaceList
  .where((element) =>
    DateFormat.yMMMEd().format(element.date) == 
    DateFormat.yMMMEd().format(DateTime.now()))
    .toList();
  fetchDateData(dateTime: sel);
  sum = 0.0;
  todaySum = 0.0;

  for (var element in finanaceList) {
    sum += element.financeValue;
  }

  for (var element in todayFinanceList) {
    todaySum += element.financeValue;
  }

  emit(FetchDataSuccess());
} on Exception catch (e) {
  emit(FetchDataFailur(e.toString()));
}
    return finanaceList;
  }

  fetchDateData({DateTime? dateTime}) {
  dateFinanceList = Hive.box<FinanceModel>("financeBox")
  .values
  .toList()
  .where((element) =>
    DateFormat.yMMMEd().format(element.date) == 
    DateFormat.yMMMEd().format(dateTime ?? DateTime.now()))
    .toList();
  }
}