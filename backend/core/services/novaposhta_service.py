# core/services/novaposhta_service.py

import requests

from typing import Dict, Any, List


class NovaPoshtaService:
    BASE_URL = "https://api.novaposhta.ua/v2.0/json/"

    @classmethod
    def track_ttn(cls, ttn: str) -> Dict[str, Any]:
        """
        Track a TTN (consignment number) using Nova Poshta API.
        Returns structured tracking info.
        """
        NP_STATUS_MAP = {
            "1": "processing",   # waiting from sender
            "2": "canceled",     # deleted
            "3": "canceled",     # number not found (maybe canceled)
            "4": "shipping",     # in sender’s city
            "41": "shipping",    # in sender’s city for local standard and express services
            "5": "in_transit",   # shipment going to recipient’s city
            "6": "in_transit",   # shipment in recipient’s city, expected delivery
            "7": "in_transit",   # arrived at warehouse
            "8": "in_transit",   # arrived at warehouse for local standard and express services
            "9": "delivered",    # shipment received
            "10": "received",    # delivered + money transfer
        }
        payload = {
            "modelName": "TrackingDocument",
            "calledMethod": "getStatusDocuments",
            "methodProperties": {
                "Documents": [
                    {"DocumentNumber": ttn}
                ]
            }
        }

        try:
            response = requests.post(cls.BASE_URL, json=payload, timeout=10)
            response.raise_for_status()
        except requests.RequestException as e:
            return {"success": False, "error": f"Request failed: {e}"}

        data = response.json()

        if not data.get("success", False):
            return {
                "success": False,
                "error": data.get("errors", ["Unknown error"]),
                "warnings": data.get("warnings", [])
            }

        result: List[Dict[str, Any]] = data.get("data", [])
        if not result:
            return {"success": False, "error": "No tracking data found"}

        tracking_info = result[0]  # only one TTN requested

        return {
            "success": True,
            "status": tracking_info.get("Status"),
            "status_code": tracking_info.get("StatusCode"),
            "status_transcription": NP_STATUS_MAP.get(tracking_info.get("StatusCode")),
            "city_sender": tracking_info.get("CitySender"),
            "city_recipient": tracking_info.get("CityRecipient"),
            "recipient_name": tracking_info.get("RecipientFullNameEW"),
            "delivery_date": tracking_info.get("ActualDeliveryDate"),
            "warehouse_sender": tracking_info.get("WarehouseSender"),
            "warehouse_recipient": tracking_info.get("WarehouseRecipient"),
            "ttn": tracking_info.get("Number"),
            "raw": tracking_info  # full response
        }