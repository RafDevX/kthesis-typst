
// vv FIXME: use actual package name
#import "../src/lib.typ": kth-thesis, setup-appendices

#show: kth-thesis.with(primary-lang: "en")

// Tip: when tagging elements, scope labels like <intro:goals:example>

= Introduction <intro>

See @bg:a1 for more information.

#lorem(50)

== Problem

#lorem(100)

== Purpose

#lorem(50)

== Goals

#lorem(100)

== Structure of the Thesis

#lorem(50)

= Background

#lorem(50)

== Major Background Area 1 <bg:a1>

=== Subarea 1.1

As mentioned in @intro, ...

=== Subarea 1.2

This is explained in @usage.

== Major Background Area 2

#lorem(20)

== Related Work Area

#lorem(50)

== Summary

#lorem(20)

= Method or Methods

#lorem(50)

== Research Process

#lorem(30)

== Data Collection

#lorem(10)

=== Sampling

#lorem(20)

=== Sample Size

#lorem(25)

=== Target Population

#lorem(30)

== Evaluation Framework

#lorem(20)

= The Thing

== Software Design

#lorem(50)

== Implementation

#lorem(1250)

=== An Example Listing

#figure(caption: [An innocuous command], raw("rm -rf /")) <thing:impl:cmd>

#lorem(30)

= Results and Analysis

#lorem(100)

= Discussion

#lorem(200)

= Conclusions and Future Work

In conclusion, execute @thing:impl:cmd.

#show: setup-appendices

= Usage Instructions <usage>

Hmm...

#lorem(1000)

= Something Else

Whoa!
