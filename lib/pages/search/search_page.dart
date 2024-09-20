import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/search/widgets/movie_search.dart';
import 'package:movie_app/services/api_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

const List<String> genres = <String>['Action', 'Comedy', 'Drama', 'Horror'];
List<Map<String, dynamic>> genreList = [
  {'id': 28, 'nome': 'Action'},
  {'id': 35, 'nome': 'Comedy'},
  {'id': 18, 'nome': 'Drama'},
  {'id': 27, 'nome': 'Horror'}
];

const List<String> Nogenres = <String>['Action', 'Comedy', 'Drama', 'Horror'];
List<Map<String, dynamic>> NogenreList = [
  {'id': 28, 'nome': 'Action'},
  {'id': 35, 'nome': 'Comedy'},
  {'id': 18, 'nome': 'Drama'},
  {'id': 27, 'nome': 'Horror'}
];

const List<String> languages = <String>['en-us', 'pt-br'];

class _SearchPageState extends State<SearchPage> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  late Future<Result> result;

  void search(int? id, int? idnogenre, String? language) {
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

  getSelectedGenreId() {
    if (selectedGenreId == null) {
      return 28;
    }
    return selectedGenreId;
  }

  setSelectedGenreId(int? value) {
    setState(() {
      selectedGenreId = value;
    });
  }

  getNoselectedGenreId() {
    if (selectedNoGenreId == null) {
      return 27;
    }
    return selectedNoGenreId;
  }

  setNoselectedGenreId(int? value) {
    setState(() {
      selectedNoGenreId = value;
    });
  }

  getSelectLanguage() {
    if (selectLanguage == null) {
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Selec. Genero',
                                  style: TextStyle(color: Colors.white),
                                ),
                                DropdownButton<String>(
                                  value: dpValue,
                                  dropdownColor: Colors.grey[800],
                                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                                  underline: const SizedBox(),
                                  style: const TextStyle(color: Colors.white),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dpValue = value!;
                                      for (var item in genreList) {
                                        if (item['nome'] == dpValue) {
                                          selectedId = item['id'];
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
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Excluir Genero',
                                  style: TextStyle(color: Colors.white),
                                ),
                                DropdownButton<String>(
                                  value: dpValueNoGenre,
                                  dropdownColor: Colors.grey[800],
                                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                                  underline: const SizedBox(),
                                  style: const TextStyle(color: Colors.white),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dpValueNoGenre = value!;
                                      for (var item in NogenreList) {
                                        if (item['nome'] == dpValueNoGenre) {
                                          selectedId = item['id'];
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
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Linguagem',
                                  style: TextStyle(color: Colors.white),
                                ),
                                DropdownButton<String>(
                                  value: dpValueLanguages,
                                  dropdownColor: Colors.grey[800],
                                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                                  underline: const SizedBox(),
                                  style: const TextStyle(color: Colors.white),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<Result>(
                future: result,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data?.movies;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          searchTitle,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          itemCount: data!.length,
                          itemBuilder: (context, index) {
                            if (data[index].backdropPath.isEmpty) {
                              return const SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Card(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 5,
                                child: MovieSearch(movie: data[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
