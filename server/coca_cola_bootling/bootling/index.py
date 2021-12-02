import json
from random import uniform, randrange

from flask import Flask, jsonify, request

from bootling.model.error import ErrorSchema, Error
from bootling.model.error_type import ErrorType
from bootling.model.rate import RateSchema, Rate
from bootling.model.status import Status, StatusSchema
from bootling.model.transaction_type import TransactionType

app = Flask(__name__)

main_status = [
    Status(0)
]

bootling_status = [
    Status(1)
]

rate = []

pressure = []

error = []

@app.route('/all')
def get_att():

    m_status = StatusSchema(many=True).dump(
        filter(lambda t: t.type == TransactionType.STATUS, main_status)
    )
    b_status = StatusSchema(many=True).dump(
        filter(lambda t: t.type == TransactionType.STATUS, bootling_status)
    )

    rate.clear()
    if main_status[0].get_status() != 0:
        rate.append(Rate(round(uniform(14., 16.), 2)))
    else:
        rate.append(Rate(0))
    p_rate = RateSchema(many=True).dump(
        filter(lambda t: t.type == TransactionType.RATE, rate)
    )

    pressure.clear()
    if main_status[0].get_status() != 0:
        pressure.append(Rate(round(uniform(15., 25.), 1)))
    else:
        pressure.append(Rate(0))
    p_pressure = RateSchema(many=True).dump(
        filter(lambda t: t.type == TransactionType.RATE, pressure)
    )

    error_generator()
    errors = ErrorSchema(many=True).dump(
        filter(lambda t: t.type == TransactionType.ERRORS, error)
    )

    return jsonify(m_status, b_status, p_rate, p_pressure, errors)


@app.route('/main_status')
def get_main_status():
    schema = StatusSchema(many=True)
    status = schema.dump(
        filter(lambda t: t.type == TransactionType.STATUS, main_status)
    )
    return jsonify(status)


@app.route('/main_status', methods=['POST'])
def set_main_status():
    current_status = StatusSchema().load(request.get_json())
    main_status.clear()
    main_status.append(current_status)

    return "", 204


@app.route('/bottling_status')
def get_bootling_status():
    schema = StatusSchema(many=True)
    status = schema.dump(
        filter(lambda t: t.type == TransactionType.STATUS, bootling_status)
    )
    return jsonify(status)


@app.route('/bottling_status', methods=['POST'])
def set_bootling_status():
    current_status = StatusSchema().load(request.get_json())
    bootling_status.clear()
    bootling_status.append(current_status)
    return "", 204


@app.route('/rate')
def get_current_rate():
    schema = RateSchema(many=True)
    rate.clear()
    if main_status[0].get_status() != 0:
        rate.append(Rate(round(uniform(14., 16.), 2)))
    else:
        rate.append(Rate(0))
    production_rate = schema.dump(
      filter(lambda t: t.type == TransactionType.RATE, rate)
    )
    return jsonify(production_rate)


@app.route('/pressure')
def get_current_pressure():
    schema = RateSchema(many=True)
    pressure.clear()
    if main_status[0].get_status() != 0:
        pressure.append(Rate(round(uniform(15., 25.), 1)))
    else:
        pressure.append(Rate(0))
    production_pressure = schema.dump(
      filter(lambda t: t.type == TransactionType.RATE, pressure)
    )
    return jsonify(production_pressure)


@app.route('/messages')
def get_messages():
    schema = ErrorSchema(many=True)
    error_generator()
    errors = schema.dump(
      filter(lambda t: t.type == TransactionType.ERRORS, error)
    )
    return jsonify(errors)


def error_generator():
    if len(rate) > 0:
        error.clear()
        if rate[0].get_val() < 15:
            error.append(Error(ErrorType.WARNING.value,
                               "Rate too low!",
                               f"Rate of {rate[0].get_val()} is less than 15."))
        elif rate[0].get_val() > 16:
            error.append(Error(ErrorType.WARNING.value,
                               "Rate too fast!",
                               f"Rate of {rate[0].get_val()} is over than 16."))
        else:
            error.append(Error(ErrorType.INFO.value,
                               "Rate OK!",
                               f"Rate of {rate[0].get_val()} is OK."))
    else:
        error.append(Error(ErrorType.CRITICAL.value, "No rate set!", "No rate has been set."))


if __name__ == "__main__":
    app.run()
