import 'package:core/core.dart';
import 'package:flutter/material.dart';

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
      case RequestState.loading:
        return loadingWidget != null
            ? loadingWidget!.call(context)
            : const Center(
                child: CircularProgressIndicator(),
              );
      case RequestState.error:
        return errorWidget != null
            ? errorWidget!.call(context)
            : Center(
                key: const Key('error_message'),
                child: Text(errorMessage ?? ''),
              );
      case RequestState.loaded:
        return loadedWidget.call(context);
      default:
        return const SizedBox();
    }
  }
}
