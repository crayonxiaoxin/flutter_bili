import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// 带 lottie 动画的 loading 组件
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  /// 加载动画是否覆盖在原界面之上
  final bool cover;

  const LoadingContainer(
      {Key? key,
      required this.child,
      this.isLoading = false,
      this.cover = false})
      : super(key: key);

  Widget get _loadingView {
    return Center(
      child: Lottie.asset('assets/loading.json'),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [
          child,
          isLoading ? _loadingView : Container(),
        ],
      );
    } else {
      return isLoading ? _loadingView : child;
    }
  }
}
