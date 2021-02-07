import 'package:dartz/dartz.dart';

import '../../../../core/error/failures/failures.dart';
import '../../data/models/roundtable_meta_api_response/roundtable_meta_api_response.dart';
import '../entity/category_entity/category_entity.dart';
import '../entity/roundtable_entity/roundtable_entity.dart';

abstract class RoundTableRepository {
  Future<Either<Failure, List<Category>>> getAllRoundTableCategories();
  Future<Either<Failure, List<Category>>> getMyRoundTableCategories();
  Future<Either<Failure, List<Category>>> getUpcomingRoundTableCategories();
  Future<Either<Failure, List<RoundTable>>> getAllRoundTables();
  Future<Either<Failure, List<RoundTable>>> getAllMyRoundTables();
  Future<Either<Failure, RoundTableMetaApiResponse>> getRoundTableMetaInfo();
  Future<Either<Failure, RoundTable>> retrieveRoundTable(int id);
}
