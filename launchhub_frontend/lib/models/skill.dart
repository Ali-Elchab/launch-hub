class Skill {
  final int id;
  final String name;
  int? specializationId;

  Skill({
    required this.id,
    required this.name,
    this.specializationId,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] as int,
      name: json['name'] as String,
      specializationId: json['specialization_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization_id': specializationId,
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
