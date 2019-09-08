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

import 'package:blake2b/blake2b.dart';
import 'package:fixnum/fixnum.dart';

class Hash {

  static final int _size = 32;
  
  static final int _digest_size = _size * 8;

  List<Int64> bytes;

  utf8(String string) {
    // TODO implement me
  }

  static Int8List hash(Int8List message, int offset, int len) {
    Int8List bytes = Int8List(_size);
    var b = Blake2b(_digest_size);
    b.update(message, offset, len);
    b.digest(bytes, 0);
    return bytes;
  }
}