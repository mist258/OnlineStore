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

        if not cls.API_KEY:
            raise ValueError("NovaPoshta API key not configured")

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
            "city_sender": tracking_info.get("CitySender"),
            "city_recipient": tracking_info.get("CityRecipient"),
            "recipient_name": tracking_info.get("RecipientFullNameEW"),
            "delivery_date": tracking_info.get("ActualDeliveryDate"),
            "warehouse_sender": tracking_info.get("WarehouseSender"),
            "warehouse_recipient": tracking_info.get("WarehouseRecipient"),
            "ttn": tracking_info.get("IntDocNumber"),
            "raw": tracking_info  # full response if you need extra fields
        }
