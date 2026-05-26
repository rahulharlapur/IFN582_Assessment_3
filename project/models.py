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
    seller_id: int
    cover_image: str
    status: str
    description: str
    created_at: datetime

    seller_firstname: str = None
    seller_lastname: str = None
    seller_email: str = None
    seller_phone: str = None
    latitude: float = None
    longitude: float = None
    compatibility: int = 0
    images: list = None
    documents: list = None
    host_preferences: list = None



@dataclass
class Bookmark:
    id: int
    user_id: int
    property_id: int
    note: str
    created_at: datetime

@dataclass
class Preference:
    id: int
    name: str   

@dataclass
class PropertyPreference:
    property_id: int
    preference_id: int

@dataclass
class UserPreference:
    user_id: int
    preference_id: int

@dataclass
class Enquiry:
    enquiry_id: int
    property_id: int
    buyer_id: int
    subject: str
    message: str
    created_at: datetime


@dataclass
class Offer:
    id: int
    buyer_id: int
    property_id: int
    offered_price: float
    status: str
    created_at: datetime
