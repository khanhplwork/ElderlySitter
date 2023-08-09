import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:elscus/core/models/address_models/district_model.dart';
import 'package:elscus/core/models/address_models/province_model.dart';
import 'package:elscus/core/models/address_models/ward_model.dart';
import 'package:elscus/process/event/address_event.dart';
import 'package:elscus/process/state/address_state.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../core/utils/globals.dart' as globals;

class AddressBloc {
  final eventController = StreamController<AddressEvent>();
  final stateController = StreamController<AddressState>();

  AddressBloc() {
    eventController.stream.listen((event) {
      if (event is OtherAddressEvent) {
        stateController.sink.add(OtherAddressState());
      }

    });
  }


}
