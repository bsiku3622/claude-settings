---
name: myformats-latex
description: Create or standardize LaTeX reports, papers, lab reports, and explanatory documents using Jaewon Baek's clean default-LaTeX conventions. Use when writing, reformatting, or compiling a LaTeX document or PDF where title metadata, page flow, theorem numbering, figures, tables, citations, or references should be consistent.
---

# My LaTeX Format

Follow the principle **Simple is Best**. Preserve the recognizable default LaTeX `article` appearance and standardize conventions rather than adding visual branding.

For a new document, start from [assets/template.tex](assets/template.tex) and remove unused packages and environments. For an existing document, preserve its content and assignment-mandated structure while applying only the relevant conventions below.

## Baseline

- Use `\documentclass[11pt,titlepage]{article}`, A4 paper, and `margin=2.5cm` unless the assignment specifies otherwise. The `titlepage` option is required so the first physical page remains a title-only page.
- For a new Korean or mixed Korean–English document, default to pdfLaTeX with `kotex`. Preserve XeLaTeX or LuaLaTeX when the existing project requires it, but do not introduce `fontspec` or custom fonts merely for appearance.
- Use the default Computer Modern/Latin Modern family and the default serif Korean font supplied through `kotex`.
- Use `\hypersetup{hidelinks}`. Keep the default centered page number.
- Do not add colors, `tcolorbox`, decorative rules, custom title pages, `fancyhdr`, logos, tags, sidebars, or sans-serif display fonts unless the user or assignment explicitly requests them.
- Load only packages the document actually uses. Typical packages are `kotex`, `float`, `amsmath`, `amssymb`, `amsthm`, `booktabs`, `enumitem`, `geometry`, `hyperref`, `graphicx`, `caption`, `subcaption`, `cite`, and `indentfirst`.

## Title and Page Flow

- Use `\title`, `\author`, `\date`, and `\maketitle`; do not reconstruct the title block manually without a required format.
- For Jaewon's Korean school submission, default to `\author{25-059 백재원}`. For a team, write entries such as `25-059 백재원 \quad / \quad 25-008 김가온`. For an English research paper, use `Jaewon Baek` unless another author form is supplied.
- Use the supplied submission date. If none is supplied, use `\today` during drafting; replace it with an explicit date for a final reproducible submission when appropriate.
- Always reserve the first physical page for the standard title block only, even when the document has no Abstract. Put no Abstract, Contents, summary box, institution footer, or body text on that page.
- Add an Abstract only for research-style documents or when requested, and begin it after the title page. Add Contents only when it materially helps navigate a long document. Without either, begin the first body section on the page immediately after `\maketitle`.
- Do not place an institution line or other decorative metadata at the bottom of the title page unless required.

## Structure and Mathematical Statements

- Preserve section names required by the assignment. When unconstrained, choose conventional names such as `Introduction`, `Theoretical Background` or `Model and Methods`, `Results`, `Discussion`, and `Conclusion` according to the document's actual contents.
- Separate observed results from their interpretation. Do not use formatting to compensate for an unclear argument.
- Number mathematical statement types independently across the document:

```latex
\theoremstyle{definition}
\newtheorem{definition}{Definition}
\newtheorem{lemma}{Lemma}
\newtheorem{theorem}{Theorem}
\renewcommand{\proofname}{Proof}
```

This produces `Definition 1.`, `Lemma 1.`, and `Theorem 1.` rather than section-prefixed or shared counters. Add only the statement types the document uses.

## Figures and Tables

- Format figure captions as `Fig. 1. Caption` and table captions as `Table 1. Caption`:

```latex
\captionsetup[figure]{name=Fig., labelsep=period, font=small,
  justification=justified, singlelinecheck=false}
\captionsetup[table]{name=Table, labelsep=period, font=small,
  justification=centering, singlelinecheck=false}
```

- Put table captions above tables and figure captions below figures.
- Use `booktabs` with `\toprule`, `\midrule`, and `\bottomrule`; do not use vertical rules unless a supplied format requires them.
- Place `\label` immediately after `\caption`. Refer to items as `Fig.~\ref{...}`, `Table~\ref{...}`, and `Eq.~\eqref{...}` when writing English labels.
- Use `[htbp]` by default. Use `[H]` only when exact placement is important.
- Keep captions descriptive and include source or license attribution for externally sourced images.

## Citations and References

- Use numbered citations such as `[1]` and compress ranges with the `cite` package.
- For a BibTeX bibliography, use `\bibliographystyle{IEEEtran}` and a `.bib` file. The heading should remain `References`.
- Keep each citation adjacent to the claim it supports. Never invent a source, DOI, page number, or bibliographic field.
- Use IEEE reference ordering and punctuation even when entering a short bibliography manually.

## Compile and Inspect

- Compile new baseline documents with `latexmk -pdf`. Use `latexmk -xelatex` only when the document actually requires XeLaTeX.
- Resolve undefined citations and references. Review overfull boxes and fix visible overflow; do not accept a successful exit code as sufficient verification.
- Render and inspect at least the first page, one representative dense body page, and the References page. Check title balance, margins, float placement, caption form, theorem numbering, page numbers, and bibliography layout.
- Keep source assets and generated PDF, but do not deliver `.aux`, `.log`, `.out`, `.toc`, `.fls`, `.fdb_latexmk`, or SyncTeX build artifacts.
