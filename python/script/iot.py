import requests
import mysql.connector
import time

port = 80
db = {
    "host": "db",
    "user": "root",
    "password": "4IRC",
    }

emergency = {
    "database": "Emergency-db",
    "addFire": (
        "INSERT INTO Fire (idFire, coordX, coordY, intensity) " +
        "VALUES (%s, %s, %s, %s)"
        ),
    "updateFire": (
        "UPDATE Fire " +
        "SET intensity = %s " +
        "WHERE idFire = %s"
        )
    }

def emergency_connection():
    emergency_db = mysql.connector.connect(
        host = db['host'],
        user = db['user'],
        password = db['password'],
        database = emergency['database']
    )

    return emergency_db

def get_Sensor_InProgess():
    sensor_InProgress = {}
    rq_sensor = requests.get("http://api/Simulateur-db")
    sensors = rq_sensor.json()
    for sensor in sensors:
        if sensors[sensor]['nameStatus'] == 'INPROGRESS':
            sensor_InProgress[sensor] = sensors[sensor]
    
    return sensor_InProgress

def get_Declared_Fire():
    rq_fire = requests.get("http://api/Emergency-db/Fire")
    fire_InProgress = rq_fire.json()

    return fire_InProgress

def main():
    sensor_InProgress = get_Sensor_InProgess()
    fire_InProgress = get_Declared_Fire()

    emergency_db = emergency_connection()
    emergency_db_requester = emergency_db.cursor()
    
    for sensor in sensor_InProgress:
        flag = False
        for fire in fire_InProgress:
            if sensor == fire:
                flag = True
        if flag:
            value = (sensor_InProgress[sensor]['intensity'], sensor)
            emergency_db_requester.execute(emergency['updateFire'], value)
            print("Sensor : " + sensor + " UPDATED !")
        else:
            value = (sensor, sensor_InProgress[sensor]['coordX'], sensor_InProgress[sensor]['coordY'], sensor_InProgress[sensor]['intensity'])
            emergency_db_requester.execute(emergency['addFire'], value)
            print("Sensor : " + sensor + " ADDED !")
    
    emergency_db.commit()

main()