# https://playwright.dev/python/docs/writing-tests
import re
from playwright.sync_api import Page, expect


def test_lang(page: Page):
    page.goto("http://dell.gettransfer.lt/")
    locator = page.locator("html")
    expect(locator).to_have_attribute("lang", "lt")
