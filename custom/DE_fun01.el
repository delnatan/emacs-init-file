(defun wrap-region (n start end)
  "Wrap text in current region.

(wrap-region N START END)

This function is /interactive/.The argument N is supplied by prefix (C-u). START
and END is taken from a regions' mark and point, respectively.This function
replaces currently selected region

Typically used to tidy long DNA/protein sequence.  Pass a prefix before running
command. For example:

C-u 50 M-x wrap-region

"
  ;; get prefix and region into arguments
  (interactive "p\nr")
  (if (use-region-p)
      ;; if using region
      (save-excursion
      (let* ((regionp (clean-string (buffer-substring start end)))
	    (result
	     (string-join (split-string-every regionp n) "\n")))
	;; `let` body
	(kill-region start end) ;; delete current region
	(insert result) ;; insert split text
	)
    ;; otherwise
    (message "no region was selected"))
    )
 )
 

(defun split-string-every (string chars)
  "split STRING into substrings of length CHARS character

This returns a list of strings."
  (cond ((string-empty-p string) nil)
	((< (length string) chars)
	 (list string))
	(t (cons (substring string 0 chars)
		 (split-string-every (substring string chars)
				     chars)))))

(defun clean-string (string)
  "cleans input STRING

These characters are removed:
numbers, punctuation marks (non-word), whitespace, newline"
  (replace-regexp-in-string "([[:digit:][:punct:]\s\n]" "" string))
