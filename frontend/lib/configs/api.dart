class Api{
  String searchVideo(String keyword){
    return "https://youtube.googleapis.com/youtube/v3/search?part=snippet&q=$keyword&key=AIzaSyDhXTnh9CJlI05kQaXPQQgdVqOxNen9OQM";
  }
}