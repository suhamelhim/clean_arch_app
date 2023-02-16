import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mena1/app/constants.dart';
import 'package:mena1/presentation/common/state_renderer/state_renderer.dart';
import 'package:mena1/presentation/resources/strings_manager.dart';

abstract class StateFlow {
  StateRendererType getStatRendererType();

  String getMessage();
}

class LoadingState extends StateFlow {
  StateRendererType stateRendererType;
  String? message;

  LoadingState(
      {required this.stateRendererType, String message = AppStrings.loading});

  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStatRendererType() => stateRendererType;
}

class ErrorState extends StateFlow {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStatRendererType() => stateRendererType;
}

class ContentState extends StateFlow {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStatRendererType() => StateRendererType.contentState;
}

class EmptyState extends StateFlow {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStatRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on StateFlow {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStatRendererType() == StateRendererType.popupLoadingState) {
            showPopup(context, getMessage(), getStatRendererType());
            return contentScreenWidget;
          } else {
           return StateRenderer(
              message: getMessage(),
              stateRendererType: getStatRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStatRendererType() == StateRendererType.popupErrorState) {
            showPopup(context, getMessage(), getStatRendererType());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateRendererType: getStatRendererType(),
                retryActionFunction: retryActionFunction,
                message: getMessage());
          }
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getStatRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }
  _isCurrentDialogShowing(BuildContext context)=>ModalRoute.of(context)?.isCurrent!=true;
  dismissDialog(BuildContext context){
    if(_isCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }

  showPopup(BuildContext context, String message,
      StateRendererType stateRendererType) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {})));
  }
}
