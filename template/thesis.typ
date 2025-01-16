
// vv FIXME: use actual package name
#import "../src/lib.typ": kth-thesis, setup-appendices

#show: kth-thesis.with(primary-lang: "en")

// Tip: when tagging elements, scope labels like <intro:goals:example>

#include "./content/ch01-introduction.typ"
#include "./content/ch02-background.typ"
#include "./content/ch03-method.typ"
#include "./content/ch04-the-thing.typ"
#include "./content/ch05-results.typ"
#include "./content/ch06-discussion.typ"
#include "./content/ch07-conclusion.typ"

#show: setup-appendices
#include "./content/zz-a-usage.typ"
#include "./content/zz-b-else.typ"
