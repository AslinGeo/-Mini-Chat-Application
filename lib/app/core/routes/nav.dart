import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Nav {
  static void go(BuildContext context, String route, {Object? extra}) {
    context.go(route, extra: extra);
  }

  static void push(BuildContext context, String route, {Object? extra}) {
    context.push(route, extra: extra);
  }

  static void replace(BuildContext context, String route, {Object? extra}) {
    context.go(route, extra: extra);
  }
}
