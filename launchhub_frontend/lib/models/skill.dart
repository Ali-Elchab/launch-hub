class Skill {
  final int id;
  final String name;
  final int specializationId;
  final SkillPivot pivot;

  Skill({
    required this.id,
    required this.name,
    required this.specializationId,
    required this.pivot,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] as int,
      name: json['name'] as String,
      specializationId: json['specialization_id'] as int,
      pivot: SkillPivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization_id': specializationId,
      'pivot': pivot.toJson(),
    };
  }
}

class SkillPivot {
  final int jobSeekerId;
  final int skillId;

  SkillPivot({
    required this.jobSeekerId,
    required this.skillId,
  });

  factory SkillPivot.fromJson(Map<String, dynamic> json) {
    return SkillPivot(
      jobSeekerId: json['job_seeker_id'] as int,
      skillId: json['skill_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_seeker_id': jobSeekerId,
      'skill_id': skillId,
    };
  }
}
