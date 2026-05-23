from dataclasses import dataclass
from datetime import datetime


@dataclass
class User:
    id: int
    firstname: str
    lastname: str
    email: str
    password: str
    phone: str
    role: str


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