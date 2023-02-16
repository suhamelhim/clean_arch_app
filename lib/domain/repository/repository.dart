import 'package:dartz/dartz.dart';
import 'package:mena1/data/network/requests.dart';
import 'package:mena1/domain/models.dart';

import '../../data/network/failure.dart';

abstract class Repository{
Future< Either <Failure,Authentication>> login(LoginRequest loginRequest);
}