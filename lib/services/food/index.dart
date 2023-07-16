import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:imc_project_app/main.dart';
import 'package:imc_project_app/services/food/models/food_model.dart';
import 'package:imc_project_app/services/food/models/food_user_model.dart';
import 'package:imc_project_app/services/food/models/schedule_model.dart';
import 'package:imc_project_app/services/food/models/user_food_request_model.dart';

class FoodService {
  Future<Either<Exception, List<FoodModel>>> getFoods() async {
    try {
      final response = await supabase
          .from(
            'food',
          )
          .select(
            'id, name, calories',
          );

      if (response.length == 0) {
        return Left(Exception('No hay alimentos registrados'));
      }

      final List<FoodModel> foods = response
          .map<FoodModel>(
            (e) => FoodModel(
              id: e['id'],
              name: e['name'],
              calories: double.parse(e['calories'].toString()),
            ),
          )
          .toList();

      return Right(foods);
    } catch (e) {
      return Left(Exception('Error al obtener los alimentos'));
    }
  }

  Future<Either<Exception, List<ScheduleModel>>> getSchedules() async {
    try {
      final response = await supabase
          .from(
            'schedule',
          )
          .select(
            'id, name',
          );

      if (response.length == 0) {
        return Left(Exception('No hay horarios registrados'));
      }

      final List<ScheduleModel> schedules = response
          .map<ScheduleModel>(
            (e) => ScheduleModel(
              id: e['id'],
              name: e['name'],
            ),
          )
          .toList();

      return Right(schedules);
    } catch (e) {
      return Left(Exception('Error al obtener los horarios'));
    }
  }

  Future<Either<Exception, bool>> saveUserFood({
    required String foodId,
    required String scheduleId,
    required String calories,
  }) async {
    try {
      await supabase
          .from(
            'user_food',
          )
          .insert(
            UserFoodRequestModel(
              foodId: foodId,
              scheduleId: scheduleId,
              calories: double.parse(calories),
              userId: supabase.auth.currentUser!.id,
            ).toJson(),
          );

      return const Right(true);
    } catch (e) {
      return Left(Exception('Error al guardar el alimento'));
    }
  }

  Future<Either<Exception, List<Map<String, String>>>> getUserFood() async {
    try {
      final response = await supabase
          .from(
            'user_food',
          )
          .select(
            'calories, createdAt, schedule (name), food (name)',
          )
          .eq(
            'userId',
            supabase.auth.currentUser!.id,
          );

      if (response.length == 0) {
        return Left(Exception('No hay alimentos registrados'));
      }

      final List<Map<String, String>> userFoods = response
          .map<Map<String, String>>(
            (e) => FoodUserModel(
              foodName: e['food']['name'].toString(),
              calories: e['calories'].toString(),
              scheduleName: e['schedule']['name'].toString(),
              createdAt: e['createdAt'].toString(),
            ).toJson(),
          )
          .toList();

      return Right(userFoods);
    } catch (e) {
      return Left(Exception('Error al obtener los alimentos'));
    }
  }
}