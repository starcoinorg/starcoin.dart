abstract class HostMananger {
    List<String> getAvailableHosts();

    void removeFailureHost(String host);

}

class MockHostManager{

  final Set<String> hosts;

  MockHostManager(this.hosts);

  List<String> getAvailableHosts(){
    return hosts.toList();
  }

  void removeFailureHost(String host){
    hosts.remove(host.toLowerCase());
  }

}