from flask import Blueprint, render_template, request, session, flash
from .db import get_properties, search_properties
from . import mysql
from .forms import SearchForm
bp = Blueprint('main', __name__)

@bp.route('/')
def index():
    form = SearchForm()
    properties = get_properties()
    return render_template('home.html', form=form, properties=properties)



@bp.route('/search', methods=['GET', 'POST'])
def search():

    form = SearchForm()
    if form.validate_on_submit():
        properties = search_properties(form)
    else:
        properties = get_properties()

    return render_template(
        'home.html',
        form=form,
        properties=properties
    )