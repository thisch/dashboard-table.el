[![Build Status](https://github.com/thisch/dashboard-table.el/workflows/CI/badge.svg)](https://github.com/thisch/dashboard-table.el/actions)

dashboard-table.el
==================

This emacs package is a tiny wrapper around `tabulated-list-mode`, which
allows adding multiple tables into a tabulated list buffer. All the tables
need to have the same columns (It is planned to get rid of this limitation
in the future).

## Installation

As of 2022-01-05 the package is not yet available in a package repository
and has to be installed manually with `package-install-file`.

## Usage

Similar to the usage of `tabulated-list-mode`. A package that wants to use
`dashboard-table.el` needs to create a derived major mode (See documentation
of `tabulated-list-mode`).

Here is a small example that shows how the package can be used.

```el
(require 'dashboard-table)

(defun example-table-get-section-data (section-data)
  "Return a list with \"tabulated-list-entries\"."
  (seq-map (lambda (row)
      ;; The used-entry-id is unique here, because this ensures that the
      ;; current position is prpoperly restured if you use e.g.
      ;; tabulated-list-widen-current-column.
      `(,(list section-data row) [,(format "A%dbingobingo" row) "Blasdfadsdfav" "Cllllmmmmmm"]))
      (number-sequence 1 (car section-data))))

(define-derived-mode example-table-mode dashboard-table-mode "example-table"
  "example-table mode"
  ;; you can use a local keymap here
  (variable-pitch-mode)
  )

(defun example-table ()
  "Show a dashboard in a new buffer."
  (interactive)
  (switch-to-buffer "example-table")
  (example-table-mode)
  (setq dashboard-table-section-alist
        '(("Section1" . (5 0))
          ("Section2" . (2 0))))
  (setq dashboard-table-columns
        [("Key" 3)
         ("Name" 20)
         ("Status" 5)
         ])
  (setq dashboard-table-get-section-data-function
        #'example-table-get-section-data)
  (dashboard-table--refresh))
```

This is the dashboard generated by `example-table`

![table](https://user-images.githubusercontent.com/206581/147606417-414f7478-89c0-4c1e-a124-7dfc868f7529.png)

## Keybindings

`dashboard-table.el` defines the following keybindings

* <kbd>g</kbd> Refresh the buffer and restore position of point.
