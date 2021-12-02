from marshmallow import post_load
from .transaction import ErrorTransaction, ErrorTransactionSchema
from .transaction_type import TransactionType


class Error(ErrorTransaction):
    def __init__(self, error_type, title, content):
        super(Error, self).__init__(error_type, title, content, TransactionType.ERRORS)

    def __repr__(self):
        return '<Rate(name={self.error!r})>'.format(self=self)


class ErrorSchema(ErrorTransactionSchema):
    @post_load
    def make_expense(self, data, **kwargs):
        return Error(**data)
