#include <cpr/cpr.h>
#include <iostream>
#include <nlohmann/json.hpp>

using json = nlohmann::json;

int main() {
  cpr::Url URL{
    "http://www.dnd5eapi.co/api/"
    "monsters/giant-spider"
  };

  cpr::Response Res{cpr::Get(URL)};

  json Doc{json::parse(Res.text)};

  std::cout
      << Doc.at("name").get<std::string>()
      << '\n'
      << Doc.at("desc").get<std::string>();
}
