import 'package:flutter/material.dart';

import '../../common/state_enum.dart';

class StateWidgetBuilder extends StatelessWidget {
  final RequestState state;
  final WidgetBuilder loadedWidget;
  final WidgetBuilder? loadingWidget;
  final WidgetBuilder? errorWidget;
  final String? errorMessage;
  const StateWidgetBuilder({
    Key? key,
    required this.state,
    required this.loadedWidget,
    this.loadingWidget,
    this.errorWidget,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case RequestState.Loading:
        return loadingWidget != null
            ? loadingWidget!.call(context)
            : Center(
                child: CircularProgressIndicator(),
              );
      case RequestState.Error:
        return errorWidget != null
            ? errorWidget!.call(context)
            : Center(
                child: Text(errorMessage ?? ''),
              );
      case RequestState.Loaded:
        return loadedWidget.call(context);
      default:
        return const SizedBox();
    }
  }
}
