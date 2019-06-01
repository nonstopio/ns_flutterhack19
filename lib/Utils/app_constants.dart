import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

typedef CallBackWithData<T> = Function(T value);
typedef SimpleCallBack = Function();

DateFormat dateFormatter = DateFormat('yyyy-MM-dd');




enum PageState {
  Loaded,
  Loading,
  Error,
}

