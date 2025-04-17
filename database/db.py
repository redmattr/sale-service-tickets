from datetime import datetime
import sqlite3
import os

from flask import current_app, g
import click 

# Establishes a connection to the database
def get_db():
    if 'db' not in g:
        g.db = sqlite3.connect(
            current_app.config['DATABASE'],
            detect_types=sqlite3.PARSE_DECLTYPES
        )
        g.db.row_factory = sqlite3.Row

    return g.db

# If there is a db connection current upon request, close connection
def close_db(e=None):
    db = g.pop('db', None)
    if db is not None:
        db.close()

# Initialize database with standard schema and default values
def init_db():
    db = get_db()

    schema_path = os.path.join(os.path.dirname(__file__), 'events_ticketing_schema.sql')
    with open(schema_path, 'r', encoding='utf8') as f:
        db.executescript(f.read())

@click.command('init-db')
def init_db_command():
    """Clear the existing data and create new tables."""
    init_db()
    click.echo('Initialized the database.')

# Just registers the datetime to sqlite datetime within the database
sqlite3.register_converter(
    "timestamp", lambda v: datetime.fromisoformat(v.decode())
)

def init_app(app):
    app.teardown_appcontext(close_db)
    app.cli.add_command(init_db_command)
