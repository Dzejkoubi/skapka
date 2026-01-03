import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/providers/account_provider.dart';

bool isUserAdmin(BuildContext context) {
  return Provider.of<AccountProvider>(context, listen: false).rights >= 3;
}
