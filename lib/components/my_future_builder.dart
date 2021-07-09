import 'package:flutter/material.dart';
import 'dart:core';

// ignore: must_be_immutable
class MyFutureBuilder<T> extends StatelessWidget {
  final Future future;
  Widget Function(dynamic error) errorWidget;
  Widget Function(T data) successWidget;

  MyFutureBuilder({
    this.future,
    this.errorWidget,
    this.successWidget,
  });

  @override
  build(BuildContext context) {
    return FutureBuilder<T>(
        future: this.future,
        builder: (BuildContext context, AsyncSnapshot snapshotData) {
          switch (snapshotData.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                  child: Container(child: CircularProgressIndicator()));

            case ConnectionState.none:
              return Center(child: Text('Check Your Internet Connection'));
              break;
            case ConnectionState.done:
              if (snapshotData.hasError) {
                return this.errorWidget != null
                    ? this.errorWidget(snapshotData.error)
                    : Center(child: Text('${snapshotData.error}'));
              } else {
                return this.successWidget(snapshotData.data);
              }
              break;
            default:
              return Container();
          }
        });
  }
}
