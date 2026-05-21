part of '../app_extension.dart';

abstract class _KAppSetting<Current, Switch> {
  Current get current;

  void switchTo(Switch value);
}
