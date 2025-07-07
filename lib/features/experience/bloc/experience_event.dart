abstract class ExperienceEvent{
  
}

class getDataExperience extends ExperienceEvent{
  final int? nextPage;
  final int? destination_id;
  final String? token;
  
  getDataExperience({ this.nextPage, this.destination_id,  this.token});

}