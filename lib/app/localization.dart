import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MaterialLocalizationTj extends DefaultMaterialLocalizations {
  MaterialLocalizationTj() : super();

  @override
  String get pasteButtonLabel => 'ГУЗОШТАН';

  @override
  String get copyButtonLabel => 'НУСХА';

  @override
  String get cutButtonLabel => 'ГИРИФТАН';

  @override
  String get selectAllButtonLabel => 'ҲАМА';
}

class CupertinoLocalizationTj extends DefaultCupertinoLocalizations {
  CupertinoLocalizationTj() : super();

  @override
  String get pasteButtonLabel => 'ГУЗОШТАН';

  @override
  String get copyButtonLabel => 'НУСХА';

  @override
  String get cutButtonLabel => 'ГИРИФТАН';

  @override
  String get selectAllButtonLabel => 'ҲАМА';
}

class TjLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const TjLocalizationsDelegate();

  @override
  Future<MaterialLocalizationTj> load(Locale locale) {
    return SynchronousFuture(MaterialLocalizationTj());
  }

  @override
  bool shouldReload(TjLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) {
    if (locale == const Locale('tj')) {
      return true;
    } else {
      return false;
    }
  }
}

class TjLocalizationsDelegateC
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const TjLocalizationsDelegateC();

  @override
  Future<CupertinoLocalizationTj> load(Locale locale) {
    return SynchronousFuture(CupertinoLocalizationTj());
  }

  @override
  bool shouldReload(TjLocalizationsDelegateC old) => false;

  @override
  bool isSupported(Locale locale) {
    if (locale == const Locale('tj')) {
      return true;
    } else {
      return false;
    }
  }
}
