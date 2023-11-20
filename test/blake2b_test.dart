///
/// Copyright (c) [2019] [riclava]
/// [blake2b] is licensed under the Mulan PSL v1.
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
import 'package:blake2b/blake2b_hash.dart';
import 'package:blake2b/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hex/hex.dart';

void main() {
  bool _uint8ListEqual(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

  test('test', () {
    ///
    /// CASE 1 - hash utf8 string
    ///

    // what we expect
    // bip = mean fury common entire zoo cash fragile dilemma retire appear insect park
    // hash = A064E3C0E7D606F7EE717718FD23B943328ACD8CC20DE29B4053FC1C9D3888F6
    // bytes = -96 100 -29 -64 -25 -42 6 -9 -18 113 119 24 -3 35 -71 67 50 -118 -51 -116 -62 13 -30 -101 64 83 -4 28 -99 56 -120 -10

    Int8List expect = Int8List.fromList([-96, 100, -29, -64, -25, -42, 6, -9, -18, 113, 119, 24, -3, 35, -71, 67, 50, -118, -51, -116, -62, 13, -30, -101, 64, 83, -4, 28, -99, 56, -120, -10]);
    Uint8List uexpect = Utils.int8list2uint8list(expect);

    var bip = "mean fury common entire zoo cash fragile dilemma retire appear insect park";
    var upperCaseHash = "A064E3C0E7D606F7EE717718FD23B943328ACD8CC20DE29B4053FC1C9D3888F6";

    Int8List message = Int8List(bip.length);
    for (int i = 0; i < bip.length; i++) {
      message[i] = bip.codeUnitAt(i);
    }

    // hash from bytes to bytes
    var umessage = Utils.int8list2uint8list(message);

    var bytes = Blake2bHash.hash(umessage, 0, umessage.length);
    assert(_uint8ListEqual(bytes, uexpect));

    // hash from hex string to hex string
    var lowerCaseHash = Blake2bHash.hashHexString2HexString(HEX.encode(message));
    assert(lowerCaseHash == upperCaseHash.toLowerCase());

    // hash from utf8 string to hex string
    lowerCaseHash = Blake2bHash.hashUtf8String2HexString(bip);
    assert(lowerCaseHash == upperCaseHash.toLowerCase());

    ///
    /// CASE 2 - hash bytes
    ///

    // another test
    // hexString = 00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000eea2f40ef9c40caffc91d82c3332456039d9562290fe0957bad9ca7bc8e9159900000014d7338a9fc7b42de9c2045635a2bf2ec628f47adec76f8ee6caaa5397025b74e400000000000186a000ae0000000000989680a54407d81a2e4d5c72b8d784a56f88736c64bdf90883c12b6ffff6ec892b2b0c00846d656d6f
    // hash = ff773f774a4489c98429d37ba1e8c91ce0ac26af27cd32c1b6ef17843e87eb39
    var hexString =
        "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000eea2f40ef9c40caffc91d82c3332456039d9562290fe0957bad9ca7bc8e9159900000014d7338a9fc7b42de9c2045635a2bf2ec628f47adec76f8ee6caaa5397025b74e400000000000186a000ae0000000000989680a54407d81a2e4d5c72b8d784a56f88736c64bdf90883c12b6ffff6ec892b2b0c00846d656d6f";
    var messageBytes = Utils.int8list2uint8list(Int8List.fromList(HEX.decode(hexString)));
    var hash = Blake2bHash.hash(messageBytes, 64, messageBytes.length - 64);
    var expectedHash = Utils.int8list2uint8list(Int8List.fromList(HEX.decode("ff773f774a4489c98429d37ba1e8c91ce0ac26af27cd32c1b6ef17843e87eb39")));
    assert(_uint8ListEqual(hash, expectedHash));

    ///
    /// CASE 3 - custom
    ///

    String preSalt = 'preSalt';
    int digestSize = 16;
    Uint8List bPreSalt = Uint8List.fromList(preSalt.codeUnits);
    Uint8List salt = Uint8List(digestSize);
    final Blake2b blake2b = Blake2b.blake2b(null, digestSize, null, null);
    blake2b.update(bPreSalt, 0, bPreSalt.length);
    Uint8List hashBytes = blake2b.digest(salt, 0);
    var hashStr = HEX.encode(hashBytes);
    print(hashStr);
  });
}
