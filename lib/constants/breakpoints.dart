import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

Widget Breakpoints(context, widget) => ResponsiveBreakpoints.builder(
      child: widget!,
      breakpoints: [
        const Breakpoint(start: 0, end: 768, name: MOBILE),
        const Breakpoint(start: 769, end: 1024, name: TABLET),
        const Breakpoint(start: 1025, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: 'XL'),
      ],
    );
