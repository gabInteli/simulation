from flask import Flask, render_template, redirect, request

import asyncio
from datetime import datetime
from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker
from models.base import Base
from models.coordenate import Coordenate

app = Flask(__name__)

header = []
engine = create_engine("sqlite+pysqlite:///coordenates.db", echo=True)
Session = sessionmaker(bind = engine)
session = Session()

Base.metadata.create_all(engine)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/post', methods=["POST"])
def postForm():
    print(request.form)
    c1 = Coordenate(x=request.form['x'], y=request.form['y'], z=request.form['z'])

    session.add(c1)
    session.commit()
    return render_template('index.html', x=request.form['x'], y=request.form['y'], z=request.form['z'])

@app.route('/godot', methods=["GET", "POST"])
def godot_coords():
    coordenadas = session.query(Coordenate).all()
    if coordenadas:
        x = coordenadas[-1].x
        y = coordenadas[-1].y
        z = coordenadas[-1].z
    godotstring = f"{x}/{y}/{z}"
    return godotstring


app.run(host = '0.0.0.0', port=3000, debug=True)