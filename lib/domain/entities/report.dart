class Report {
  Report({
    this.id,
    required this.id_support,
    required this.id_client,
    required this.problem,
    required this.time_started,
    required this.time_end,
    required this.calification,
  });

  int? id;
  int id_support;
  int id_client;
  String problem;
  DateTime time_started;
  DateTime time_end;
  int calification;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        id_support: json["id_support"] ?? "someIdSupport",
        id_client: json["id_client"] ?? "someIdClient",
        problem: json["problem"] ?? "someProblem",
        time_started: json["time_started"] ?? "",
        time_end: json["time_end"] ?? "",
        calification: json["calification"] ?? 0, 
      );

  Map<String, dynamic> toJson() => {
        //"id": id ?? 0, // id is not required when adding a new user
        "id_support": id_support,
        "id_client": id_client,
        "problem": problem,
        "time_started": time_started,
        "time_end": time_end,
        "calification": calification,
      };
}
