abstract class PackageServiceEvent{}
class GetAllPackageServiceEvent extends PackageServiceEvent{

}

class GetPackageDetailPackageServiceEvent extends PackageServiceEvent{
  GetPackageDetailPackageServiceEvent({required this.packageID});
  String packageID;
}

class GetRandomPackageServiceEvent extends PackageServiceEvent{
  GetRandomPackageServiceEvent({required this.count});
  int count;
}