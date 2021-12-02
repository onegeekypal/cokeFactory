from marshmallow import post_load
from .transaction import RateTransactionSchema, RateTransaction
from .transaction_type import TransactionType


class Rate(RateTransaction):
    def __init__(self, rate):
        super(Rate, self).__init__(rate, TransactionType.RATE)

    def __repr__(self):
        return '<Rate(name={self.rate!r})>'.format(self=self)

    def get_val(self):
        return self.rate


class RateSchema(RateTransactionSchema):
    @post_load
    def set_rate(self, data, **kwargs):
        return Rate(**data)
