from flask import Blueprint, render_template, request, session, flash,redirect, url_for
from .db import get_properties, search_properties , create_user, user_exists, check_for_user
from .forms import SearchForm, RegisterForm, LoginForm
from hashlib import sha256

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

@bp.route('/register', methods=['GET', 'POST'])
def register():
    form = RegisterForm()
    if request.method == 'POST' and form.validate_on_submit():
        form.password.data = sha256(form.password.data.encode()).hexdigest()
        user = user_exists(form.email.data)
        if user:
            flash("Username or email already exists. Please choose another.", "danger")
            return redirect(url_for('main.register'))
        create_user(form)
        flash("Account created successfully! Please log in.", "success")
        return redirect(url_for('main.login'))

    return render_template('register.html', form=form)

@bp.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if request.method == 'POST' and form.validate_on_submit():
        form.password.data = sha256(form.password.data.encode()).hexdigest()
        user = check_for_user(form.email.data, form.password.data)
        if not user:
            flash("Invalid email or password. Please try again.", "danger")
            return redirect(url_for('main.login'))
        print(user)
        session["user"]={
            "id": user.id,
            "firstname": user.firstname,
            "lastname": user.lastname,
            "email": user.email,
            "phone": user.phone,
            "is_admin": user.role == "admin",
            "role": user.role
        }
        session["logged_in"] = True
        flash("Logged in successfully!", "success")
        return redirect(url_for('main.index'))

    return render_template('login.html', form=form)

@bp.route('/logout')
def logout():
    session.pop('user', None)
    session.pop('logged_in', None)
    flash('You have been logged out.','info')
    return redirect(url_for('main.index'))
