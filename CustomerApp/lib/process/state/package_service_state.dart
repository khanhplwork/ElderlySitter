import 'package:elscus/core/models/package_service_models/package_service_data_model.dart';
import 'package:elscus/core/models/package_service_models/package_service_detail_data_model.dart';
import 'package:elscus/core/models/package_service_models/package_service_model.dart';

abstract class PackageServiceState {}
class GetAllPackageServiceState extends PackageServiceState{
  GetAllPackageServiceState({required this.listPackage});
  PackageServiceModel listPackage;
}

class GetPackageDetailPackageServiceState extends PackageServiceState{
  GetPackageDetailPackageServiceState({required this.packageDetail});
  PackageServiceDetailDataModel packageDetail;
}

class GetRandomPackageServiceState extends PackageServiceState{
  GetRandomPackageServiceState({required this.listPackage});
  final List<PackageServiceDataModel> listPackage;
}