from flask_wtf import FlaskForm
from wtforms.fields import StringField, SelectField, SubmitField


class SearchForm(FlaskForm):

    location = StringField("Suburb or Postcode")

    property_type = SelectField(
        "Type",
        choices=[
            ("Any Type", "Any Type"),
            ("House", "House"),
            ("Apartment", "Apartment"),
            ("Unit", "Unit")
        ]
    )

    price_range = SelectField(
        "Weekly Rent",
        choices=[
            ("Any Price", "Any Price"),
            ("Under $300", "Under $300"),
            ("$300 - $500", "$300 - $500"),
            ("$500 - $800", "$500 - $800"),
            ("$800+", "$800+")
        ]
    )

    bedrooms = SelectField(
        "Bedrooms",
        choices=[
            ("Any Room", "Any Room"),
            ("1", "1"),
            ("2", "2"),
            ("3", "3"),
            ("4+", "4+")
        ]
    )

    sort_by = SelectField(
    "Sort By",
    choices=[
        ("default", "Sort by - Recently Added"),
        ("price_low", "Sort by - Price (Low to High)"),
        ("price_high", "Sort by - Price (High to Low)"),
    ]
)

    submit = SubmitField("Search")

