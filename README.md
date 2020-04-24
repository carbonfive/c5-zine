Welcome to C5 Zine
=================

This is where we store our zine which was originally
written on [https://zine-machine.glitch.me/](https://zine-machine.glitch.me/).

Current Zine should be on GH Pages at [https://carbonfive.github.io/c5-zine](https://carbonfive.github.io/c5-zine).

Making Changes
--------------

It's good old HTML/CSS.  The only Javascript is a 3 line script that hooks up
the print button.  Aside from that there is `index.html` and `style.css`.

The CSS should not have to change much (if at all).  If you modify it, be
aware that there are `@media screen` and `@media print` rules.  So if you've added rules
that are *not* appropriate for printing or might affect that, please check the
`@media print` rules to make them correct.

e.g. The print button has no place in the printed version so we have the rule
```css
.print-button { display: none; }
```
in the `@media print` section.

Files and Organization
----------------------

* `index.html` will point to the current zine
* assets (as needed) can be stored under `images/issue?/` where ? is the issue number.
* `style.css` should remain consistent enough that it works for all issues

Publishing a new issue
----------------------

* Create an `issue?` branch where ? is the next issue number.
* Copy `index.html` to `issue?.html`
* Add `issue?.html` to the repo
* Add assets and edit `index.html` to represent the new issue
* submit a PR.
* after it's merged, move `gh-pages` to the new master.
* tag that SHA with a date stamped tag : `issue?-YYYYMMDD`
* push it live

Authors:
* [@nikkythayer](https://github.com/nikkithayer)
* [@bunnymatic](https://github.com/bunnymatic)

