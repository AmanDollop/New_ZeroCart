class TrackingModal {
  TrackingData? trackingData;

  TrackingModal({this.trackingData});

  TrackingModal.fromJson(Map<String, dynamic> json) {
    trackingData = json['tracking_data'] != null
        ? TrackingData.fromJson(json['tracking_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (trackingData != null) {
      data['tracking_data'] = trackingData!.toJson();
    }
    return data;
  }
}

class TrackingData {
  int? trackStatus;
  int? shipmentStatus;
  List<ShipmentTrack>? shipmentTrack;
  List<ShipmentTrackActivities>? shipmentTrackActivities;
  String? trackUrl;
  String? etd;

  TrackingData(
      {this.trackStatus,
        this.shipmentStatus,
        this.shipmentTrack,
        this.shipmentTrackActivities,
        this.trackUrl,
        this.etd});

  TrackingData.fromJson(Map<String, dynamic> json) {
    trackStatus = json['track_status'];
    shipmentStatus = json['shipment_status'];
    if (json['shipment_track'] != null) {
      shipmentTrack = <ShipmentTrack>[];
      json['shipment_track'].forEach((v) {
        shipmentTrack!.add(ShipmentTrack.fromJson(v));
      });
    }
    if (json['shipment_track_activities'] != null) {
      shipmentTrackActivities = <ShipmentTrackActivities>[];
      json['shipment_track_activities'].forEach((v) {
        shipmentTrackActivities!.add(ShipmentTrackActivities.fromJson(v));
      });
    }
    trackUrl = json['track_url'];
    etd = json['etd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['track_status'] = trackStatus;
    data['shipment_status'] = shipmentStatus;
    if (shipmentTrack != null) {
      data['shipment_track'] =
          shipmentTrack!.map((v) => v.toJson()).toList();
    }
    if (shipmentTrackActivities != null) {
      data['shipment_track_activities'] =
          shipmentTrackActivities!.map((v) => v.toJson()).toList();
    }
    data['track_url'] = trackUrl;
    data['etd'] = etd;
    return data;
  }
}

class ShipmentTrack {
  int? id;
  String? awbCode;
  int? courierCompanyId;
  int? shipmentId;
  int? orderId;
  String? pickupDate;
  String? deliveredDate;
  String? weight;
  int? packages;
  String? currentStatus;
  String? deliveredTo;
  String? destination;
  String? consigneeName;
  String? origin;
  String? courierAgentDetails;
  String? edd;

  ShipmentTrack(
      {this.id,
        this.awbCode,
        this.courierCompanyId,
        this.shipmentId,
        this.orderId,
        this.pickupDate,
        this.deliveredDate,
        this.weight,
        this.packages,
        this.currentStatus,
        this.deliveredTo,
        this.destination,
        this.consigneeName,
        this.origin,
        this.courierAgentDetails,
        this.edd});

  ShipmentTrack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    awbCode = json['awb_code'];
    courierCompanyId = json['courier_company_id'];
    shipmentId = json['shipment_id'];
    orderId = json['order_id'];
    pickupDate = json['pickup_date'];
    deliveredDate = json['delivered_date'];
    weight = json['weight'];
    packages = json['packages'];
    currentStatus = json['current_status'];
    deliveredTo = json['delivered_to'];
    destination = json['destination'];
    consigneeName = json['consignee_name'];
    origin = json['origin'];
    courierAgentDetails = json['courier_agent_details'];
    edd = json['edd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['awb_code'] = awbCode;
    data['courier_company_id'] = courierCompanyId;
    data['shipment_id'] = shipmentId;
    data['order_id'] = orderId;
    data['pickup_date'] = pickupDate;
    data['delivered_date'] = deliveredDate;
    data['weight'] = weight;
    data['packages'] = packages;
    data['current_status'] = currentStatus;
    data['delivered_to'] = deliveredTo;
    data['destination'] = destination;
    data['consignee_name'] = consigneeName;
    data['origin'] = origin;
    data['courier_agent_details'] = courierAgentDetails;
    data['edd'] = edd;
    return data;
  }
}

class ShipmentTrackActivities {
  String? date;
  String? status;
  String? activity;
  String? location;
  String? srStatus;

  ShipmentTrackActivities(
      {this.date, this.status, this.activity, this.location, this.srStatus});

  ShipmentTrackActivities.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
    activity = json['activity'];
    location = json['location'];
    srStatus = json['sr-status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['status'] = status;
    data['activity'] = activity;
    data['location'] = location;
    data['sr-status'] = srStatus;
    return data;
  }
}
