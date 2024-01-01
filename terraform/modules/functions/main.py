from flask import Flask, request, jsonify
from kafka import KafkaProducer
from kafka.errors import KafkaError
import random
import json
import time

app = Flask(__name__)

def generate_flight_data():
    # ... (function remains unchanged)

@app.route('/kafka_producer', methods=['POST'])
def kafka_producer():
    # Simula la ingesta de datos
    data = generate_flight_data()

    # Configuración del productor de Kafka
    producer = KafkaProducer(
        bootstrap_servers=['localhost:9092'],
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )

    # Publica datos en el tópico de Kafka
    try:
        producer.send('aerolinea_tema', value=data)
        producer.flush()
        # **Código corregido:**
        # return jsonify({"status": "success", "message": "Datos publicados en Kafka."})
        return {
            "status": "success",
            "message": "Datos publicados en Kafka."
        }
    except KafkaError as e:
        return {
            "status": "error",
            "message": str(e)
        }, 500

if __name__ == '__main__':
    app.run(debug=True, port=8080)  # Use app.run directly for Flask