#import "./covers.typ": *
#import "./front-matter.typ": *
#import "./styling-setup.typ": *
#import "./utils.typ": get-one-liner, extract-name

#let kth-thesis(
  // Primary document language; either "en" or "sv"
  primary-lang: "en",
  // Language-specific title, subtitle, abstract, and keywords.
  // Grouped by language, with only values for "en" and "sv" being mandatory.
  // Localized abstract/keywords headings may be omitted only for "en" and "sv".
  localized-info: (
    en: (
      title: "How to Abandon Dinosaur-Age TypeSetting Software",
      subtitle: "A Modern Approach to Problem-Solving",
      abstract: lorem(300),
      keywords: ("Dogs", "Chicken nuggets"),
    ),
    sv: (
      title: "Svenska Översättningen av Titeln",
      subtitle: "Svenska Översättningen av Undertiteln",
      abstract: lorem(300),
      keywords: ("Hundar", "Kycklingnuggets"),
    ),
    pt: (
      title: "Tradução em Português do Título",
      subtitle: "Tradução em Português do Subtítulo",
      abstract-heading: "Resumo",
      keywords-heading: "Palavras-chave",
      abstract: lorem(300),
      keywords: ("Cães", "Nuggets de frango"),
    ),
  ),
  // Ordered author information; only first and last names fields are mandatory
  authors: (
    (
      first-name: "John",
      last-names: "Doe",
      email: "john.doe@example.com",
      user-id: "jod",
      school: "School of Electrical Engineering and Computer Science",
      department: "Department of Typesetting Sanity",
    ),
    (
      first-name: "Jane",
      last-names: "Doe",
    ),
  ),
  // Ordered supervisor information; "external-org" replaces userid/school/dept
  supervisors: (
    (
      first-name: "Alice",
      last-names: "Smith",
      email: "alice@example.com",
      user-id: "alice",
      school: "School of Electrical Engineering and Computer Science",
      department: "Department of Loyal Supervision",
    ),
    (
      first-name: "Bob",
      last-names: "Jones",
      email: "bob@example.com",
      external-org: "Företag AB",
    ),
  ),
  // Thesis examiner; must be internal so all fields are mandatory
  examiner: (
    first-name: "Charlie",
    last-names: "Johnson",
    email: "charlie@example.com",
    user-id: "chj",
    school: "School of Electrical Engineering and Computer Science",
    department: "Department of Fair Examination",
  ),
  // Bologna cycle of education; either 1 or 2
  cycle: 2,
  // Number of ECTS credits
  credits: 30,
  // Degree as part of which the thesis is conducted; all fields are mandatory
  degree: (
    code: "TCYSM",
    name: "Master's Program, Cybersecurity",
    kind: "Master's degree",
    subject-area: "Technology",
  ),
  // School that the thesis is part of
  school: "EECS",
  // TRITA number assigned to thesis after final examiner approval
  trita-number: "2024:0000",
  // Host company collaborating for this thesis; may be none
  host-company: "Företag AB",
  // Host organization collaborating for this thesis; may be none
  host-org: none,
  // Acknowledgements body
  acknowledgements: {
    par(lorem(100))
    par(lorem(150))
  },
  // Additional front-matter sections, each with keys "heading" and "body".
  // For example, ((heading: "Acronyms and Abbreviations", body: glossary),)
  extra-preambles: (),
  // Document date; hardcode for determinism/reproducibility
  doc-date: datetime.today(),
  // Document city (where it's being signed/authored/submitted)
  doc-city: "Stockholm",
  // Extra keywords, embedded in document metadata but not listed in text
  doc-extra-keywords: ("master thesis",),
  // Document body
  body,
) = {
  let alt-lang = if primary-lang == "en" {
    "sv"
  } else if primary-lang == "sv" {
    "en"
  } else {
    panic("Invalid primary language " + primary-lang)
  }

  let primary-info = localized-info.at(primary-lang)
  let alt-info = localized-info.at(alt-lang)

  let author-names = authors.map(extract-name)

  set document(
    title: get-one-liner(primary-lang, primary-info),
    // vvv - will be available in Typst 0.13.0 (update typst.toml#compiler!)
    // description: get-one-liner(alt-lang, alt-info), // Subject field
    date: doc-date,
    keywords: primary-info.at("keywords") + doc-extra-keywords,
    author: author-names,
  )
  set page("a4")
  set text(lang: primary-lang, size: 12pt)

  front-cover(
    title: primary-info.at("title"),
    subtitle: primary-info.at("subtitle"),
    authors: author-names,
    subject-area: degree.at("subject-area"),
    cycle: cycle,
    credits: credits,
  )

  page[] // blank

  title-page(
    title: primary-info.at("title"),
    subtitle: primary-info.at("subtitle"),
    alt-title: alt-info.at("title"),
    alt-subtitle: alt-info.at("subtitle"),
    alt-lang: alt-lang,
    degree: degree.at("name"),
    date: doc-date,
    authors: author-names,
    supervisors: supervisors.map(extract-name),
    examiner-name: extract-name(examiner),
    examiner-school: examiner.at("school"),
    host-company: host-company,
    host-org: host-org,
  )

  copyright-page(year: doc-date.year(), authors: author-names)

  global-setup({
    set page(numbering: "i")
    counter(page).update(1)

    for (lang, info) in localized-info {
      page(
        localized-abstract(
          lang: lang,
          abstract-heading: info.at("abstract-heading", default: none),
          keywords-heading: info.at("keywords-heading", default: none),
          keywords: info.at("keywords"),
          info.at("abstract"),
        ),
      )
      page(header: none, footer: none, []) // blank
    }

    page(
      signed-acknowledgements(
        city: doc-city,
        date: doc-date,
        authors: author-names,
        acknowledgements,
      ),
    )

    page(indices)

    for extra in extra-preambles {
      page(extra-preamble(title: extra.at("heading"), extra.at("body")))
    }

    pagebreak(weak: true, to: "odd")

    set page(numbering: "1")
    counter(page).update(1)
    pagebreak()

    styled-body(body)
  })

  let trita-series = school + "-EX"

  pagebreak(to: "odd")
  page[] // empty
  back-cover(
    trita-series: trita-series,
    trita-number: trita-number,
    year: doc-date.year(),
  )
}
