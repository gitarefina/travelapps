class DestinationModel {
    DestinationModel({
        required this.code,
        required this.status,
        required this.message,
        required this.dataDestination,
    });

    final int? code;
    final bool? status;
    final String? message;
    final List<DataDestination> dataDestination;

    DestinationModel copyWith({
        int? code,
        bool? status,
        String? message,
        List<DataDestination>? dataDestination,
    }) {
        return DestinationModel(
            code: code ?? this.code,
            status: status ?? this.status,
            message: message ?? this.message,
            dataDestination: dataDestination ?? this.dataDestination,
        );
    }

    factory DestinationModel.fromJson(Map<String, dynamic> json){ 
        return DestinationModel(
            code: json["code"],
            status: json["status"],
            message: json["message"],
            dataDestination: json["data"] == null ? [] : List<DataDestination>.from(json["data"]!.map((x) => DataDestination.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": dataDestination.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$code, $status, $message, $dataDestination, ";
    }
}

class DataDestination {
    DataDestination({
        required this.destinationId,
        required this.typeSource,
        required this.typeName,
        required this.name,
        required this.packageTypeId,
    });

    final int? destinationId;
    final String? typeSource;
    final String? typeName;
    final String? name;
    final int? packageTypeId;

    DataDestination copyWith({
        int? destinationId,
        String? typeSource,
        String? typeName,
        String? name,
        int? packageTypeId,
    }) {
        return DataDestination(
            destinationId: destinationId ?? this.destinationId,
            typeSource: typeSource ?? this.typeSource,
            typeName: typeName ?? this.typeName,
            name: name ?? this.name,
            packageTypeId: packageTypeId ?? this.packageTypeId,
        );
    }

    factory DataDestination.fromJson(Map<String, dynamic> json){ 
        return DataDestination(
            destinationId: json["destination_id"],
            typeSource: json["type_source"],
            typeName: json["type_name"],
            name: json["name"],
            packageTypeId: json["package_type_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "destination_id": destinationId,
        "type_source": typeSource,
        "type_name": typeName,
        "name": name,
        "package_type_id": packageTypeId,
    };

    @override
    String toString(){
        return "$destinationId, $typeSource, $typeName, $name, $packageTypeId, ";
    }
}
