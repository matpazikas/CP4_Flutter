import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/search/widgets/movie_search.dart';
import 'package:movie_app/services/api_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

const List<String> genres = <String>[ 'Action', 'Comedy', 'Drama', 'Horror'];
List<Map<String, dynamic>> genreList = [

  {'id': 28, 'nome': 'Action'},
  {'id': 35, 'nome': 'Comedy'},
  {'id': 18, 'nome': 'Drama'},
  {'id': 27, 'nome': 'Horror'}
];

const List<String> Nogenres = <String>[ 'Action', 'Comedy', 'Drama', 'Horror'];
List<Map<String, dynamic>> NogenreList = [

  {'id': 28, 'nome': 'Action'},
  {'id': 35, 'nome': 'Comedy'},
  {'id': 18, 'nome': 'Drama'},
  {'id': 27, 'nome': 'Horror'}
];

String genero = "Action";

const List<String> languages = <String>['en-us', 'pt-br'];
String selectedLanguage = 'en-us';

class _SearchPageState extends State<SearchPage> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  late Future<Result> result;

  void search(int? id, int? idnogenre, String?language) {
    setState(() {
      if (id == 00) {
        setState(() {
          result = apiServices.getPopularMovies();
        });
      } else {
        setState(() {
          result = apiServices.getMoviesWithGenre(id, idnogenre, language);
        });
      }
    });
  }

  @override
  void initState() {
    result = apiServices.getPopularMovies();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  int? selectedGenreId;
  int? selectedNoGenreId;
  String? selectLanguage = languages.first;

  String dpValue = genreList.first['nome'];
  String dpValueNoGenre = NogenreList.last['nome'];
  String dpValueLanguages = languages.first;
  int? selectedId;
  String? selectedLanguage;

  getSelectedGenreId(){
    if(selectedGenreId == null){
      return 28;
    }
    return selectedGenreId;
  }

  setSelectedGenreId(int? value) {
    setState(() {
      selectedGenreId = value;
    });
  }

  getNoselectedGenreId(){
    if(selectedNoGenreId == null){
      return 27;
    }
    return selectedNoGenreId;
  }

  setNoselectedGenreId(int? value) {
    setState(() {
      selectedNoGenreId = value;
    });
  }

  getSelectLanguage(){
    if(selectLanguage == null){
      return 'en-us';
    }
    return selectLanguage;
  }

  setSelectLanguage(String? value) {
    setState(() {
      selectLanguage = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    final searchTitle = searchController.text.isEmpty
        ? 'Top Searches'
        : 'Search Result for ${searchController.text}';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Contém gênero',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        DropdownButton<String>(
                          value: dpValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.white),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dpValue = value!;
                              for (var item in genreList) {
                                if (item['nome'] == dpValue) {
                                  selectedId = item['id']; // Pega o ID
                                  break;
                                }
                              }
                              setSelectedGenreId(selectedId);
                              search(selectedId, getNoselectedGenreId(), getSelectLanguage());
                            });
                          },
                          items: genres.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Não contém genero',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        DropdownButton<String>(
                          value: dpValueNoGenre,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.white),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dpValueNoGenre = value!;
                              for (var item in NogenreList) {
                                if (item['nome'] == dpValueNoGenre) {
                                  selectedId = item['id']; // Pega o ID
                                  break;
                                }
                              }
                              setNoselectedGenreId(selectedId);
                              search(getSelectedGenreId(), selectedId, getSelectLanguage());
                            });
                          },
                          items: Nogenres.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Idioma',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        DropdownButton<String>(
                          value: dpValueLanguages,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.white),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dpValueLanguages = value!;
                              
                            });
                              setSelectLanguage(dpValueLanguages);
                              search(getSelectedGenreId(), getNoselectedGenreId(), dpValueLanguages);
                          },
                          items: languages.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FutureBuilder<Result>(
                future: result,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data?.movies;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            searchTitle,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              if (data[index].backdropPath.isEmpty) {
                                return const SizedBox();
                              }
                              return MovieSearch(movie: data[index]);
                            },
                          )
                        ]);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
