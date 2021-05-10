abstract class HostMananger {
    String getHttpBaseUrl();

    String getWsBaseUrl();

    void removeFailureHost(String host);

}

class SimpleHostManager extends HostMananger{

  final Set<String> hosts;

  SimpleHostManager(this.hosts);

  String getHttpBaseUrl(){
    if(hosts.isNotEmpty)
      return "http://" + hosts.first + ":9850";
    else
      throw Exception("no available host");
  }

  String getWsBaseUrl(){
    if(hosts.isNotEmpty)
      return "ws://" + hosts.first + ":9870";
    else
      throw Exception("no available host");
  }


  void removeFailureHost(String host){
    hosts.remove(host.toLowerCase());
  }

}