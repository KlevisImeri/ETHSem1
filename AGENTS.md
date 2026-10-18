# Lecture notes writing conventions

Apply these conventions when creating or editing definitions and related mathematical material in this repository's lecture notes.

- Put the mathematical definition first: formulas, quantifiers, algorithm arrows, and conditions.
- Put symbol descriptions below the definition in an aligned LaTeX block, using `symbol &:\text{ meaning}`. Text should primarily explain what symbols denote.
- Prefer compact mathematical notation over explanatory paragraphs. Do not add prose introductions, remarks, or conceptual explanations unless the user asks for them or they are essential to avoid ambiguity.
- Keep each quantified condition and its algorithm expression on the same line when it fits. Align expressions immediately after the quantifiers' colon using `&`.
- Use the numbered `definition` environment for definitions, under the lecture requested by the user.
- Preserve the lecture's notation and conventions, including parameter domains. Do not introduce extra notation such as `\operatorname{Supp}` when the lecture already provides equivalent notation.
- Keep syntax, correctness, and security as separate definitions or properties.
- Preserve existing formatting and make only changes relevant to the request.
