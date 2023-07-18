import 'package:dartz/dartz.dart';
import 'package:imc_project_app/main.dart';
import 'package:imc_project_app/services/imc/models/imc_user_model.dart';

class ImcService {
  Future<Either<Exception, List<Map<String, String>>>> getUserImc() async {
    try {
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        return Left(Exception('No hay usuario logueado'));
      }

      final response = await supabase.from('user_imc').select().eq(
            'userId',
            userId,
          );

      final actualResponse = response.map<Map<String, String>>((e) {
        return ImcUserModel(
          imc: e['imc'].toString(),
          height: e['height'],
          weight: e['weight'],
          createdAt: e['createdAt'].toString(),
        ).toJson();
      }).toList();

      return Right(actualResponse);
    } catch (e) {
      return Left(Exception('Ups! Algo salió mal.'));
    }
  }

  Future<Either<Exception, List<Map<String, String>>>> getUserImcByDateFilter({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        return Left(Exception('No hay usuario logueado'));
      }

      print(startDate);
      print('keninsin');
      print(endDate);
      print('kimycita');

      final response = await supabase
          .from('user_imc')
          .select()
          .eq('userId', userId)
          .gte('createdAt', startDate)
          .lte('createdAt', endDate);

      print(response);

      final actualResponse = response.map<Map<String, String>>((e) {
        return ImcUserModel(
          imc: e['imc'].toString(),
          height: e['height'],
          weight: e['weight'],
          createdAt: e['createdAt'].toString(),
        ).toJson();
      }).toList();

      return Right(actualResponse);
    } catch (e) {
      print(e);

      return Left(Exception('Ups! Algo salió mal.'));
    }
  }
}
