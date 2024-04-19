import os

from index import loadEnv


def test_env():
    """Env test"""
    loadEnv()
    assert os.environ.get("DB_PATH") != None
    assert os.environ.get("SQL_INIT") != None
