import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';

 Widget skeletonLoading(){
   return ListSkeleton(
      style: SkeletonStyle(
        theme: SkeletonTheme.Light,
        isShowAvatar: true,
        barCount: 2,
        colors: [Color(0xffF2F0F0), Color(0xff8C8888), Color(0xffF2F0F0)],
        isAnimation: true,
      ),
    );
 }