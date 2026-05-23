from dataclasses import dataclass
from datetime import datetime

@dataclass
class Property:
    id: int
    title: str
    property_type: str
    price: float
    suburb: str
    city: str
    postcode: str
    bedrooms: int
    bathrooms: int
    occupants: int
    image: str
    description: str
    created_at: datetime
    