class Hobby {
  final int id;
  final String name;
  final Pivot pivot;

  Hobby({
    required this.id,
    required this.name,
    required this.pivot,
  });

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      id: json['id'] as int,
      name: json['name'] as String,
      pivot: Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pivot': pivot.toJson(),
    };
  }
}

class Pivot {
  final int jobSeekerId;
  final int hobbyId;

  Pivot({
    required this.jobSeekerId,
    required this.hobbyId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      jobSeekerId: json['job_seeker_id'] as int,
      hobbyId: json['hobby_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_seeker_id': jobSeekerId,
      'hobby_id': hobbyId,
    };
  }
}
