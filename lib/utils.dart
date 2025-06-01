import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(text)));
  }

  static toDateTime(Timestamp value) {
    return value.toDate();
  }

  static fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }

  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>> transformer<T>(
      T Function(Map<String, dynamic> json) fromJson) {
    return StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>.fromHandlers(
      handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
        final snaps = data.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        final objects = snaps.map((json) => fromJson(json)).toList();

        sink.add(objects);
      },
    );
  }
}