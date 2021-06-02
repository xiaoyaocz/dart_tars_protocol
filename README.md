# dart_tars_protocol

dart编码及解码Tars协议数据。

此项目移植自 [tup-csharp](https://github.com/TarsCloud/TarsTup/tree/master/tup-csharp)

## 使用

example:

```dart
import 'package:dart_tars_protocol/tars_output_stream.dart';
import 'package:dart_tars_protocol/tars_input_stream.dart';

main() {
  //encode
  var out = TarsOutputStream();
  out.write(false,0);
  out.write("ok",1);
  var bytes= out.toUint8List();
  //decode
  var input = TarsInputStream(bytes);
  print(input.readBool(0,false));//print:false
  print(input.readString(1,false));//print:ok
}


```

## 参考

[TarsTup](https://github.com/TarsCloud/TarsTup)

[TarsProtocol](https://github.com/TarsCloud/TarsProtocol)
