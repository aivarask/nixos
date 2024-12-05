# https://playwright.dev/python/docs/writing-tests
import re
from playwright.sync_api import Page, expect

HTTP_HOST = "dell.gettransfer.lt"


def test_lang_default(page: Page):
    page.goto("http://%s/" % (HTTP_HOST))
    locator = page.locator("html")
    expect(locator).to_have_attribute("lang", "lt")


def test_lang_lt(page: Page):
    page.goto("http://dell.gettransfer.lt/lt/")
    locator = page.locator("html")
    expect(locator).to_have_attribute("lang", "lt")


def test_lang_en(page: Page):
    page.goto("http://dell.gettransfer.lt/en/")
    locator = page.locator("html")
    expect(locator).to_have_attribute("lang", "en")
