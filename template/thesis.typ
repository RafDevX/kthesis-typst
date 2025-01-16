
// vv FIXME: use actual package name
#import "../src/lib.typ": kth-thesis, setup-appendices

// The template is extensible and plays well with other dependencies;
// For example, a table of acronyms can be generated using glossarium
#import "@preview/glossarium:0.5.1": make-glossary, register-glossary, print-glossary
#import "./acronyms.typ": acronyms
#show: make-glossary
#register-glossary(acronyms)

// Configure formatting options before invoking the template;
// For example, uncomment below to set another font (except for covers)
// #set text(font: "New Computer Modern")

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

= Temporary Appendix
// TODO: make this an extra preamble
#print-glossary(acronyms)
