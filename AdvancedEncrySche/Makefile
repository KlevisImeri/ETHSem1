PDFUNITE ?= pdfunite

LECTURE_PDFS := $(sort $(wildcard lecture_*.pdf))
EXERCISE_PDFS := $(sort $(wildcard ex-sheet*+sol.pdf))
MERGED_PDF := merged/course.pdf

.DELETE_ON_ERROR:
.PHONY: merge

merge: $(MERGED_PDF)

$(MERGED_PDF): $(LECTURE_PDFS) $(EXERCISE_PDFS) Makefile
	mkdir -p "$(@D)"
	$(PDFUNITE) $(LECTURE_PDFS) $(EXERCISE_PDFS) "$@"
