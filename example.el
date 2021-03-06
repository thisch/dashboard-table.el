(require 'dashboard-table)

(defun example-table-get-section-data (section)
  "Return a list with \"tabulated-list-entries\"."
  (seq-map (lambda (row)
             `((list section row) [,(format "%s-row%d-abc" section row)
                    "def"
                    "DD"]))
             '(2 4 6 9 10)))

(define-derived-mode example-table-mode dashboard-table-mode "example-table"
  "example-table mode"
  ;; use a local keymap here
  )

;;;###autoload
(defun example-table ()
  "Show a dashboard in a new buffer."
  (interactive)
  (switch-to-buffer "example-table")
  (example-table-mode)
  (setq dashboard-table-section-alist
        '(("Section1" . "pars for section1")
          ("Section2" . "pars for section2")))
  (setq dashboard-table-columns
        [("Key" 40)
         ("Name" 55)
         ("Data1" 10)
         ])
  (setq dashboard-table-get-section-data-function
        #'example-table-get-section-data)
  (dashboard-table--refresh))

;;;###autoload
(defun example-table2 ()
  "Show a dashboard in a new buffer."
  (interactive)
  (switch-to-buffer "example-table2")
  (example-table-mode)
  (setq dashboard-table-section-alist
        '(("A1" . "pars for sectionA1")
          ("B2" . "pars for sectionB2")))
  (setq dashboard-table-columns
        [("Key" 40)
         ("Name2" 55)
         ("Data1" 10)
         ])
  (setq dashboard-table-get-section-data-function
        #'example-table-get-section-data)
  (dashboard-table--refresh))


;; TODO better would be a function that takes a section alist + a column
;; format and that creates a dashboard function, because setting the alist +
;; the columns in the major mode is not very nice, especially if the user
;; should be able to define dashboards
