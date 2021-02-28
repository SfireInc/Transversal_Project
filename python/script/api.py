import json
import http.server
from http.server import BaseHTTPRequestHandler, HTTPServer
import mysql.connector

# Variable & dict
port = 80
db = {
    "host": "db",
    "user": "root",
    "password": "4IRC",
    }

simulation = {
    "database": "Simulateur-db",
    "Sensor": (
        "SELECT idSensor, nameStatus, coordX, coordY, intensity " +
        "FROM Sensor " +
        "INNER JOIN Status " +
        "ON Sensor.statusSensor = Status.idStatus"
        )
    }

emergency = {
    "database": "Emergency-db",
    "Truck": (
        "SELECT Truck.idTruck, Statement.nameStatement, Truck.coordX, Truck.coordY, Truck.idFire, FireStation.nameFireStation " +
        "FROM Truck " +
        "INNER JOIN Statement " +
        "ON Truck.statement = Statement.idStatement " +
        "INNER JOIN FireStation " +
        "ON Truck.idFireStation = FireStation.idFireStation"
        ),
    "FireStation": (
        "SELECT FireStation.idFireStation, FireStation.nameFireStation, FireStation.coordX, FireStation.coordY " +
        "FROM FireStation"
        ),
    "Fireman": (
        "SELECT Fireman.idFireman, Fireman.name, Fireman.surname, Statement.nameStatement, Fireman.idTruck, FireStation.nameFireStation, Truck.coordX, Truck.coordY " +
        "FROM Fireman " +
        "INNER JOIN Truck " +
        "ON Fireman.idTruck = Truck.idTruck " +
        "INNER JOIN Statement " +
        "ON Truck.statement = Statement.idStatement " +
        "INNER JOIN FireStation " +
        "ON Truck.idFireStation = FireStation.idFireStation "
        ),
    "Fire": (
        "SELECT Fire.idFire, Fire.coordX, Fire.coordY, Fire.intensity " +
        "FROM Fire"
        )
    }


def format_Content(db_content, db_desc):
    dictionnary = dict()
    for value in db_content:
        dictionnary[str(value[0])] = dict()
        for i in range(1, len(db_desc)):
            dictionnary[str(value[0])][str(db_desc[i][0])] = str(value[i])

    return dictionnary

def simulation_connection():
    simulation_db = mysql.connector.connect(
        host = db['host'],
        user = db['user'],
        password = db['password'],
        database = simulation['database']
    )

    return simulation_db

def emergency_connection():
    emergency_db = mysql.connector.connect(
        host = db['host'],
        user = db['user'],
        password = db['password'],
        database = emergency['database']
    )

    return emergency_db

def get_200(self, content):
    self.send_response(200)
    self.send_header("Access-Control-Allow-Origin", "*")
    self.end_headers()
    self.wfile.write(json.dumps(content, indent=4).encode())

def get_404(self):
    self.send_response(404)
    self.send_header('Content-type', 'application/json')
    self.end_headers()
    self.wfile.write("Error 404 - Content not found".encode())

def get_SimulationDB(self, simulation_db):
    simulation_db_requester = simulation_db.cursor()
    simulation_db_requester.execute(simulation['Sensor'])
    simulation_content = simulation_db_requester.fetchall()
    simulation_desc = simulation_db_requester.description

    get_200(self, format_Content(simulation_content, simulation_desc))

def get_EmergencyDBTruck(self, emergency_db):
    emergency_db_requester = emergency_db.cursor()
    emergency_db_requester.execute(emergency['Truck'])
    emergency_content = emergency_db_requester.fetchall()
    emergency_desc = emergency_db_requester.description

    get_200(self, format_Content(emergency_content, emergency_desc))

def get_EmergencyDBFireStation(self, emergency_db):
    emergency_db_requester = emergency_db.cursor()
    emergency_db_requester.execute(emergency['FireStation'])
    emergency_content = emergency_db_requester.fetchall()
    emergency_desc = emergency_db_requester.description

    get_200(self, format_Content(emergency_content, emergency_desc))

def get_EmergencyDBFireman(self, emergency_db):
    emergency_db_requester = emergency_db.cursor()
    emergency_db_requester.execute(emergency['Fireman'])
    emergency_content = emergency_db_requester.fetchall()
    emergency_desc = emergency_db_requester.description

    get_200(self, format_Content(emergency_content, emergency_desc))

def get_EmergencyDBFire(self, emergency_db):
    emergency_db_requester = emergency_db.cursor()
    emergency_db_requester.execute(emergency['Fire'])
    emergency_content = emergency_db_requester.fetchall()
    emergency_desc = emergency_db_requester.description

    get_200(self, format_Content(emergency_content, emergency_desc))

class myHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        if self.path == '/Emergency-db/Truck':
            emergency_db = emergency_connection()
            get_EmergencyDBTruck(self, emergency_db)
        elif self.path == '/Emergency-db/FireStation':
            emergency_db = emergency_connection()
            get_EmergencyDBFireStation(self, emergency_db)
        elif self.path == '/Emergency-db/Fireman':
            emergency_db = emergency_connection()
            get_EmergencyDBFireman(self, emergency_db)
        elif self.path == '/Emergency-db/Fire':
            emergency_db = emergency_connection()
            get_EmergencyDBFire(self, emergency_db)
        elif self.path == '/Simulateur-db':
            simulation_db = simulation_connection()
            get_SimulationDB(self, simulation_db)
        else:
            get_404(self)

api_rest = HTTPServer(('', port), myHandler)
print("Api-Rest started on port: " + str(port))

api_rest.serve_forever()