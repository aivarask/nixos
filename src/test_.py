import re
from playwright.sync_api import Page, expect

expect.set_options(timeout=1_000)

# https://playwright.dev/python/docs/locators
# http://localhost:8000/


def test_(page: Page):
    page.set_default_timeout(1_000)
    # page.goto("[::1]:8000")
    page.goto("http://localhost:8000")
    expect(page).to_have_title(re.compile("Home"))
    # page.screenshot(path="./src/test_.png")
    page.get_by_role("button", name="Sign in").click()
