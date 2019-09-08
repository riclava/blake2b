///
/// Copyright (c) [2019] [name of copyright holder]
/// [Software Name] is licensed under the Mulan PSL v1.
/// You can use this software according to the terms and conditions of the Mulan PSL v1.
/// You may obtain a copy of Mulan PSL v1 at:
///     http://license.coscl.org.cn/MulanPSL
/// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
/// PURPOSE.
/// See the Mulan PSL v1 for more details.
///
import 'dart:typed_data';

import 'package:blake2b/ushr.dart';

class Hex {

  static final Int8List _rawHexTable = Int8List.fromList([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, -1, -1, -1, -1, -1, -1, -1, 10, 11, 12, 13, 14, 15, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 10, 11, 12, 13, 14, 15]);

  static final List<String> _lowerCaseChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'];
  static final List<String> _upperCaseChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'];

  static Int8List fromHex(String string, int size) {
    var length = string.length;
    if (size == 0) {
      if (length % 2 == 1)
        return null;
    } else {
      if (length != size * 2)
        return null;
    }

    List<int> result = [];
    
    for (int i = 0; i < length; i += 2) {
      var firstIndex = _hexTable(string.codeUnitAt(i));
      var secondIndex = _hexTable(string.codeUnitAt(i+1));

      if (firstIndex == -1 || secondIndex == -1)
        return null;
      
      var octet = (firstIndex << 4) | secondIndex;
      result.add(octet.toInt());
    }
    return Int8List.fromList(result);
  }

  static String toHex(Int8List l, bool lowerCase) {
    List<String> table = lowerCase ? _lowerCaseChars : _upperCaseChars;
    String result = "";
    for (int i = 0; i < l.length; i++) {
      var octet = l[i];
      int firstIndex = Ushr.ushr((octet & 0xF0), 4);
      var secondIndex = octet & 0x0F;
      result += table[firstIndex];
      result += table[secondIndex];
    }
    return result;
  }

  static int _hexTable(int elem) {
    if (elem > 0 && elem < _rawHexTable.length) {
      return _rawHexTable[elem];
    }
    return -1;
  }

}