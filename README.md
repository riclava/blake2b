# blake2b

A dart implement of  blake2b referenced from [blacknet](https://blacknet.ninja/) and it's [source code](https://gitlab.com/blacknet-ninja/blacknet).

## Getting Started

```dart
Int8List expect = Int8List.fromList([-96,100,-29,-64,-25,-42,6,-9,-18,113,119,24,-3,35,-71,67,50,-118,-51,-116,-62,13,-30,-101,64,83,-4,28,-99,56,-120,-10]);

var bip = "mean fury common entire zoo cash fragile dilemma retire appear insect park";
var upperCaseHash = "A064E3C0E7D606F7EE717718FD23B943328ACD8CC20DE29B4053FC1C9D3888F6";

Int8List message = Int8List(bip.length);
for (int i = 0; i < bip.length; i++) {
    message[i] = bip.codeUnitAt(i);
}

// hash from bytes to bytes
var bytes = Blake2bHash.hash(message, 0, message.length);

assert(_int8ListEqual(bytes, expect));

// hash from hex string to hex string
assert(Blake2bHash.hashHexString2HexString(Hex.encodeHexString(message, false), false) == upperCaseHash);

// hash from utf8 string to hex string
assert(Blake2bHash.hashUtf8String2HexString(bip, false) == upperCaseHash);
```