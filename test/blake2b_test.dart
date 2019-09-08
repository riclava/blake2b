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

import 'package:blake2b/hash.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  bool _int8ListEqual(Int8List a, Int8List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
  test('test', () {
    // test blake2
    // what we expect
    // bip = mean fury common entire zoo cash fragile dilemma retire appear insect park
    // hash = A064E3C0E7D606F7EE717718FD23B943328ACD8CC20DE29B4053FC1C9D3888F6
    // bytes = -96 100 -29 -64 -25 -42 6 -9 -18 113 119 24 -3 35 -71 67 50 -118 -51 -116 -62 13 -30 -101 64 83 -4 28 -99 56 -120 -10

    Int8List expect = Int8List.fromList([-96,100,-29,-64,-25,-42,6,-9,-18,113,119,24,-3,35,-71,67,50,-118,-51,-116,-62,13,-30,-101,64,83,-4,28,-99,56,-120,-10]);

    var bip = "mean fury common entire zoo cash fragile dilemma retire appear insect park";
    
    Int8List message = Int8List(bip.length);
    for (int i = 0; i < bip.length; i++) {
      message[i] = bip.codeUnitAt(i);
    }

    var bytes = Hash.hash(message, 0, message.length);
    assert(_int8ListEqual(bytes, expect));
  });
}
