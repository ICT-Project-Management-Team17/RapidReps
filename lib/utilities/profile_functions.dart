import 'package:flutter/material.dart';

getFirmDetails(bool? freelance, String? firm) {
  if (freelance != true) {
    return Text(
      "$firm",
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 32,
      ),
    );
  }
  return const Text("");
}

getNumber(String? number) {
  if (number != null) {
    return Text(
      number,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 32,
      ),
    );
  }
}
