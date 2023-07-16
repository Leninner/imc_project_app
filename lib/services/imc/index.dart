import 'package:dartz/dartz.dart';
import 'package:imc_project_app/main.dart';
import 'package:imc_project_app/services/imc/models/imc_user_model.dart';

class ImcService {
  Future<Either<Exception, List<Map<String, String>>>> getUserImc() async {
    try {
      final response = await supabase
          .from('user_imc')
          .select()
          .eq('userId', supabase.auth.currentUser!.id);

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
}
