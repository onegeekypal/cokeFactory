from marshmallow import post_load
from .transaction import StatusTransaction, StatusTransactionSchema
from .transaction_type import TransactionType


class Status(StatusTransaction):
    def __init__(self, status):
        super(Status, self).__init__(status, TransactionType.STATUS)

    def __repr__(self):
        return '<Status(name={self.status!r})>'.format(self=self)

    def get_status(self):
        return self.status


class StatusSchema(StatusTransactionSchema):
    @post_load
    def set_status(self, data, **kwargs):
        return Status(**data)
