import re
from playwright.sync_api import Page, expect
import pytest

URL="http://localhost:8080"

def test_has_title(page: Page):
    page.goto(URL)
    expect(page).to_have_title(re.compile("gettransf"))

@pytest.mark.skipif(1==1, reason = "just skipping")
def test_get_started_link(page: Page):
    page.goto(URL)
    page.get_by_role("link", name="lang").click()
    # Expects page to have a heading with the name of Installation.
    expect(page.get_by_role("heading", name="Installation")).to_be_visible()
