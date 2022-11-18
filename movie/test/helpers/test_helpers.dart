import 'package:core/data/datasources/db/database_helper.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

@GenerateMocks([
  MovieLocalDataSource,
  MovieRemoteDataSource,
  DatabaseHelper,
  MovieRepository,
], customMocks: [
  MockSpec<Client>(as: #MockHttpClient)
])
void main() {}
