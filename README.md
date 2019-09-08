# blake2b

A dart implement of  blake2b referenced from [blacknet](https://blacknet.ninja/) and it's [source code](https://gitlab.com/blacknet-ninja/blacknet).

## Getting Started

```dart
Int8List expect = Int8List.fromList([-96,100,-29,-64,-25,-42,6,-9,-18,113,119,24,-3,35,-71,67,50,-118,-51,-116,-62,13,-30,-101,64,83,-4,28,-99,56,-120,-10]);

var bip = "mean fury common entire zoo cash fragile dilemma retire appear insect park";

Int8List message = Int8List(bip.length);
for (int i = 0; i < bip.length; i++) {
    message[i] = bip.codeUnitAt(i);
}

var bytes = Hash.hash(message, 0, message.length);
assert(_int8ListEqual(bytes, expect));
```