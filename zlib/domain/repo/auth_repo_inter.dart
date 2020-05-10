import 'package:flutter/material.dart';

abstract class IAuthRepo {
  Future login(BuildContext context, String phone, String password);
  Future register(
    BuildContext context,
    String name,
    String phone,
    String password,
    String confirmPassword,
    String email,
  );
}
