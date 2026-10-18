# Letter to Dr. Kristina Hostáková

- Recipient: kristina.hostakova@inf.ethz.ch
- Subject: A fully direct proof using a reduction
- Editable source: `letter.tex`
- Attachment: `letter.pdf`

The letter contains the email introduction, followed by the equivalence theorem and the complete IND-CPA-to-semantic-security proof copied verbatim from notes.tex, including both final proof options. It is a draft for Klevis to review and send.

The theorem and proof are exact source copies, with no mathematical corrections or additional cases. The standalone preamble supplies the same formatting and theorem number (1.14). The main lecture notes have not been changed.

The first lecture identifies Kristina Hostáková as the lecturer for the first part. Its contact slide misspells the domain as `inf.etzh.ch`. The address above is verified against ETH's official course catalogue and research-group profile:

- https://vvz.ethz.ch/Vorlesungsverzeichnis/dozent.view?ansicht=1&dozide=10121290&lang=en&semkez=2026W
- https://foc.ethz.ch/people/kristinahostakova.html

Build from this folder with `pdflatex -interaction=nonstopmode -halt-on-error letter.tex`.
