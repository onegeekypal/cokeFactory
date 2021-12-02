import datetime as dt

from marshmallow import Schema, fields


class Transaction:
    def __init__(self, description, amount, type):
        self.description = description
        self.amount = amount
        self.created_at = dt.datetime.now()
        self.type = type

    def __repr__(self):
        return '<Transaction(name={self.description!r})>'.format(self=self)


class TransactionSchema(Schema):
    description = fields.Str()
    amount = fields.Number()
    created_at = fields.DateTime()
    type = fields.Str()


class StatusTransaction:
    def __init__(self, status, type):
        self.status = status
        self.created_at = dt.datetime.now()
        self.type = type

    def __repr__(self):
        return '<StatusTransaction(name={self.status!r})>'.format(self=self)


class StatusTransactionSchema(Schema):
    status = fields.Boolean()
    created_at = fields.DateTime()
    type = fields.Str()


class RateTransaction:
    def __init__(self, rate, type):
        self.rate = rate
        self.created_at = dt.datetime.now()
        self.type = type

    def __repr__(self):
        return '<StatusTransaction(name={self.status!r})>'.format(self=self)


class RateTransactionSchema(Schema):
    rate = fields.Decimal()
    created_at = fields.DateTime()
    type = fields.Str()


class ErrorTransaction:
    def __init__(self, error_type, title, content, type):
        self.error_type = error_type
        self.title = title
        self.content = content
        self.created_at = dt.datetime.now()
        self.type = type

    def __repr__(self):
        return '<StatusTransaction(name={self.error!r})>'.format(self=self)


class ErrorTransactionSchema(Schema):
    error_type = fields.Str()
    title = fields.Str()
    content = fields.Str()
    created_at = fields.DateTime()
    type = fields.Str()
