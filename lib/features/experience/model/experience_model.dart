class ExperienceModel {
    ExperienceModel({
        required this.code,
        required this.status,
        required this.message,
        required this.data_experience,
    });

    final int? code;
    final bool? status;
    final String? message;
    final DataExperience? data_experience;

    ExperienceModel copyWith({
        int? code,
        bool? status,
        String? message,
        DataExperience? data_experience,
    }) {
        return ExperienceModel(
            code: code ?? this.code,
            status: status ?? this.status,
            message: message ?? this.message,
            data_experience: data_experience ?? this.data_experience,
        );
    }

    factory ExperienceModel.fromJson(Map<String, dynamic> json){ 
        return ExperienceModel(
            code: json["code"],
            status: json["status"],
            message: json["message"],
            data_experience: json["data"] == null ? null : DataExperience.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data_experience?.toJson(),
    };

    @override
    String toString(){
        return "$code, $status, $message, $data_experience, ";
    }
}

class DataExperience {
    DataExperience({
        required this.totalPage,
        required this.currentPage,
        required this.totalPackage,
        required this.packages,
    });

    final int? totalPage;
    final int? currentPage;
    final int? totalPackage;
    final List<Package> packages;

    DataExperience copyWith({
        int? totalPage,
        int? currentPage,
        int? totalPackage,
        List<Package>? packages,
    }) {
        return DataExperience(
            totalPage: totalPage ?? this.totalPage,
            currentPage: currentPage ?? this.currentPage,
            totalPackage: totalPackage ?? this.totalPackage,
            packages: packages ?? this.packages,
        );
    }

    factory DataExperience.fromJson(Map<String, dynamic> json){ 
        return DataExperience(
            totalPage: json["total_page"],
            currentPage: json["current_page"],
            totalPackage: json["total_package"],
            packages: json["packages"] == null ? [] : List<Package>.from(json["packages"]!.map((x) => Package.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "total_page": totalPage,
        "current_page": currentPage,
        "total_package": totalPackage,
        "packages": packages.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$totalPage, $currentPage, $totalPackage, $packages, ";
    }
}

class Package {
    Package({
        required this.packageId,
        required this.name,
        required this.price,
        required this.currency,
        required this.day,
        required this.operationTimeIn,
        required this.operationTimeOut,
        required this.timeZone,
        required this.images,
        required this.packageTypeId,
        required this.packageTypeName,
        required this.isInstallment,
        required this.destinations,
    });

    final int? packageId;
    final String? name;
    final int? price;
    final String? currency;
    final int? day;
    final String? operationTimeIn;
    final String? operationTimeOut;
    final String? timeZone;
    final List<String> images;
    final int? packageTypeId;
    final String? packageTypeName;
    final bool? isInstallment;
    final List<Destination> destinations;

    Package copyWith({
        int? packageId,
        String? name,
        int? price,
        String? currency,
        int? day,
        String? operationTimeIn,
        String? operationTimeOut,
        String? timeZone,
        List<String>? images,
        int? packageTypeId,
        String? packageTypeName,
        bool? isInstallment,
        List<Destination>? destinations,
    }) {
        return Package(
            packageId: packageId ?? this.packageId,
            name: name ?? this.name,
            price: price ?? this.price,
            currency: currency ?? this.currency,
            day: day ?? this.day,
            operationTimeIn: operationTimeIn ?? this.operationTimeIn,
            operationTimeOut: operationTimeOut ?? this.operationTimeOut,
            timeZone: timeZone ?? this.timeZone,
            images: images ?? this.images,
            packageTypeId: packageTypeId ?? this.packageTypeId,
            packageTypeName: packageTypeName ?? this.packageTypeName,
            isInstallment: isInstallment ?? this.isInstallment,
            destinations: destinations ?? this.destinations,
        );
    }

    factory Package.fromJson(Map<String, dynamic> json){ 
        return Package(
            packageId: json["package_id"],
            name: json["name"],
            price: json["price"],
            currency: json["currency"],
            day: json["day"],
            operationTimeIn: json["operation_time_in"],
            operationTimeOut: json["operation_time_out"],
            timeZone: json["time_zone"],
            images: json["images"] == null ? ["https://balidave.com/wp-content/uploads/2022/11/best-hotel-bali.jpeg"] : List<String>.from(json["images"]!.map((x) => x)),
            packageTypeId: json["package_type_id"],
            packageTypeName: json["package_type_name"],
            isInstallment: json["is_installment"],
            destinations: json["destinations"] == null ? [] : List<Destination>.from(json["destinations"]!.map((x) => Destination.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "name": name,
        "price": price,
        "currency": currency,
        "day": day,
        "operation_time_in": operationTimeIn,
        "operation_time_out": operationTimeOut,
        "time_zone": timeZone,
        "images": images.map((x) => x).toList(),
        "package_type_id": packageTypeId,
        "package_type_name": packageTypeName,
        "is_installment": isInstallment,
        "destinations": destinations.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$packageId, $name, $price, $currency, $day, $operationTimeIn, $operationTimeOut, $timeZone, $images, $packageTypeId, $packageTypeName, $isInstallment, $destinations, ";
    }
}

class Destination {
    Destination({
        required this.destinationId,
        required this.name,
    });

    final int? destinationId;
    final String? name;

    Destination copyWith({
        int? destinationId,
        String? name,
    }) {
        return Destination(
            destinationId: destinationId ?? this.destinationId,
            name: name ?? this.name,
        );
    }

    factory Destination.fromJson(Map<String, dynamic> json){ 
        return Destination(
            destinationId: json["destination_id"],
            name: json["name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "destination_id": destinationId,
        "name": name,
    };

    @override
    String toString(){
        return "$destinationId, $name, ";
    }
}
