import re
from playwright.sync_api import Page, expect

expect.set_options(timeout=1_000)

# https://playwright.dev/python/docs/locators
# http://localhost:8000/


def tes(page: Page):
    page.set_default_timeout(1_000)
    page.goto("http://localhost:8000")
    expect(page).to_have_title(re.compile("Home"))
    h = page.get_by_role("link", name="Home")
    expect(h).to_be_visible()
    a = page.get_by_role("link", name="About")
    expect(a).to_be_visible()

    # page.screenshot(path="./src/test_.png")
