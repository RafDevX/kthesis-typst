#import "@preview/linguify:0.4.1": linguify

#let kth-blue = rgb("#004791")
#let kth-navy = rgb("#000061")

#let lang-db = toml("./lang.toml")

#let t = key => linguify(key, from: lang-db)

#let get-one-liner(lang, info) = {
  let title = info.at("title")
  let subtitle = info.at("subtitle")

  // I don't really understand why this is the intended behavior either...
  if lang == "sv" {
    title + " - " + subtitle
  } else {
    title + ": " + subtitle
  }
}

#let extract-name(person) = {
  return person.at("first-name") + " " + person.at("last-names")
}

#let join-names(names) = {
  return names.join(", ", last: t("separator-last"))
}
