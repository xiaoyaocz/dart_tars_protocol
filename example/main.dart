import 'dart:io';
import 'dart:typed_data';

import 'package:dart_tars_protocol/tars_displayer.dart';
import 'package:dart_tars_protocol/tars_output_stream.dart';
import 'package:dart_tars_protocol/tars_input_stream.dart';
import 'package:dart_tars_protocol/tars_struct.dart';

void main() {
  write();
  read();
}

void write() {
  var file = File('tars.bin');
  var out = TarsOutputStream();
  //write bool
  out.write(false, 0);
  //write int
  out.write(666, 1);
  //write string
  out.write('Test字符串', 2);
  //write float
  out.writeFloat(2.33, 3);
  //write double
  out.writeDouble(6.666666, 4);
  //write list
  out.write([233, 111, 2222, 33], 5);
  //write simpleList/bytes
  out.write(Uint8List.fromList([0, 1, 2, 3]), 6);
  //write map
  out.write({
    'kye1': 1,
    'key2': 2,
  }, 7);
  //write sruct
  var testStruct = TestStruct(code: 200, message: 'ok');
  out.write(testStruct, 8);
  file.writeAsBytesSync(out.toUint8List());
}

void read() {
  var file = File('tars.bin');
  var input = TarsInputStream(file.readAsBytesSync());
  print(input.readBool(0, false));
  print(input.readInt(1, false));
  print(input.readString(2, false));
  print(input.readFloat(3, false));
  print(input.readFloat(4, false));
  print(input.readList<int>(5, false));
  print(input.readBytes(6, false));
  print(input.readMap<String, int>(7, false));
  var t = TestStruct();
  input.readTarsStruct(t, 8, false);
  t.display(StringBuffer(), 0);
}

class TestStruct extends TarsStruct {
  int code;
  String message;

  TestStruct({this.code = 0, this.message = ''});

  @override
  void display(StringBuffer sb, int level) {
    var _ds = TarsDisplayer(sb, level: level);
    _ds.Display(code, 'code');
    _ds.Display(message, 'text');
    print(sb.toString());
  }

  @override
  void readFrom(TarsInputStream _is) {
    code = _is.read(code, 0, false);
    message = _is.read(message, 1, false);
  }

  @override
  void writeTo(TarsOutputStream _os) {
    _os.write(code, 0);
    _os.write(message, 1);
  }
}
