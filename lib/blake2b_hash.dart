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
import 'package:blake2b/hex.dart';

class Blake2bHash {
  static final int _size = 32;

  static final int _digestSize = _size * 8;

  // hash from hex string to bytes
  static Int8List hashHexString(String hex) {
    if (null == hex) {
      return null;
    }
    var bytes = Hex.decodeHex(hex);
    return hash(bytes, 0, bytes.length);
  }

  // hash from hex string to hex string
  static String hashHexString2HexString(String hex, bool lowerCase) {
    return Hex.encodeHexString(hashHexString(hex), lowerCase);
  }

  // hash from utf8 string to bytes
  static Int8List hashUtf8String(String string) {
    Int8List bytes = Int8List(string.length);
    for (int i = 0; i < string.length; i++) {
      bytes[i] = string.codeUnitAt(i);
    }
    return hash(bytes, 0, bytes.length);
  }

  // hash from utf8 string to hex string
  static String hashUtf8String2HexString(String string, bool lowerCase) {
    return Hex.encodeHexString(hashUtf8String(string), lowerCase);
  }

  static Int8List hashWithDigestSize(int digestSize, Int8List message) {
    Int8List bytes = Int8List(digestSize ~/ 8);
    var b = Blake2b(digestSize);
    b.update(message, 0, message.length);
    b.digest(bytes, 0);
    return bytes;
  }

  static Int8List hash(Int8List message, int offset, int len) {
    Int8List bytes = Int8List(_size);
    var b = Blake2b(_digestSize);
    b.update(message, offset, len);
    b.digest(bytes, 0);
    return bytes;
  }
}
