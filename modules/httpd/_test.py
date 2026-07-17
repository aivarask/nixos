import re
from playwright.sync_api import Page, expect
import pytest

URL = "http://localhost:8080"


def test_has_title(page: Page):
    page.goto(URL)
    expect(page).to_have_title(re.compile("gettransf"))
    expect(page.get_by_role("heading", name="apie mus")).to_be_visible()
    page.get_by_role("link", name="en").click()
    expect(page.get_by_role("heading", name="about us")).to_be_visible()


# @pytest.mark.skipif(1 == 1, reason="just skipping")
