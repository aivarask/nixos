def inc(a):
    """Increment function"""
    return a + 1


def dec(a):
    """Decrement function"""
    return a - 1


def test_inc():
    """Increment function test"""
    assert inc(1) == 2


def test_dec():
    """Decrement test case"""
    assert dec(2) == 1
