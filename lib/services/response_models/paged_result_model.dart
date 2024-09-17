class PagedResult<T> {
  int count;
  String? next;
  String? previous;
  List<T> results;

  PagedResult({
   required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PagedResult.fromJson(Map<String, dynamic> json) {
    return PagedResult(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: json['results'],
    );
  }
}
