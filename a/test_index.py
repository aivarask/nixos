# https://playwright.dev/python/docs/writing-tests
import re
from playwright.sync_api import Page, expect


def test_lang(page: Page):
    page.goto("http://a.local/")
    html = page.locator("html")
    lang = html.get_attribute("lang")
    # expect(lang).__eq__("lang")


# def test_get_started_link(page: Page):
#     page.goto("https://playwright.dev/")

#     # Click the get started link.
#     page.get_by_role("link", name="Get started").click()

#     # Expects page to have a heading with the name of Installation.
#     expect(page.get_by_role("heading", name="Installation")).to_be_visible()
