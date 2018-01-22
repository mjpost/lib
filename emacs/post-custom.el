(defvar datetime-string "%Y-%m-%d %H:%M %A"
  "*A string specifying the format of the date-time stamp.
Refer to the documentation for format-time-string for an explanation of the
meta characters available for use in this string.  Non-meta characters will
be inserted into the buffer without interpretation.")

(defun word-count nil
  "Count words in buffer"
  (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))
(setq default-process-coding-system '(utf-8 . utf-8))
(setq default-process-coding-system '(undecided-unix . utf-8))

(defun post-pbcopy()
  "Copy the region to the Mac clipboard"
  (interactive)
  (set 'beg (if (use-region-p) (region-beginning) (point)))
  (set 'end (if (use-region-p) (region-end) (point)))
  (if (not (use-region-p))
      (display-message-or-buffer (concat "Nothing selected!"))
    (shell-command-on-region beg end (concat "tee " (substitute-in-file-name "$HOME/.pbcopy") " | pbcopy"))
    (display-message-or-buffer (concat "Copied " (number-to-string (- end beg)) " characters from " (number-to-string (count-lines beg end)) " lines"))))

;;(global-set-key "q" 'post-have-some-fun)
(defun post-have-some-fun()
  "Rebind q to randomly insert two qs"
  (interactive)
  (let ((q (+ 97 16)))
    (if (equal (random 100) 42)
        (insert-char q 2)
      (insert-char q 1))))

(defun post-insert-datetime-string (arg)
  "Insert the date and time into the current buffer at the current location.
   See the documentation for datetime-string to change the format of the
   date-time stamp."
  (interactive "p")
  (if (equal arg 1)
      ;; default to YYYY-MM-DD
      (insert (format-time-string "%Y-%m-%d" (current-time)))
    (if (equal arg 2)
        ;; just the time
        (insert (format-time-string "%H:%M" (current-time)))
      (if (equal arg 3)
          ;; just the day
          (insert (format-time-string "%A" (current-time)))
        ;; the entire string YYYY-MM-DD HH:MM NNNNNNNN
        (insert (format-time-string datetime-string (current-time)))))))


(defun post-fill-asterisk (arg)
  "Fills the line from point to arg with asterisks. If arg is not
   given it stops at column 65."
  (interactive "p")
  (let ((c (if (not (equal (char-before) 32)) (char-before) 42)) ;default to *
        (stop (if (= 1 arg) (- (window-width) 1) arg)))
    (message "Filled to column %d with character %s" stop c)
    (insert-char c (- stop (current-column)))))

(defun mouse-scroll-up()
  "Scrolls up four lines. TODO: linearly increase the number of lines
   scrolled up as a function of how fast the scrolling is happening."
  (interactive) (next-line 4))

(defun mouse-scroll-down()
  "Scrolls down four lines."
  (interactive) (previous-line 4))


;;  compute-sum.el

;;  Benjamin Van Durme, vandurme@cs.rochester.edu,  6 Oct 2005
;;  Time-stamp: <2005-10-07 12:13:47 vandurme>
;;  Changes
;;    2005-10-11 Modified to remove old sum (MJP)
;;    2006-09-01 Changed name to column-sum

(defun column-sum (column)
  "Tallies the second column of current buffer, inserts the sum at EOB."
  (interactive "p")
  (save-excursion
    (let ((sum 0))
      (goto-char (point-min))
      (while (not (= (point) (point-max)))
        (beginning-of-line)
        (if (not (eq (symbol-at-point) nil))
            (progn
              (forward-word column)
              (setq sum (+ sum (read (current-buffer))))))
        (forward-line)
        (end-of-line))
      (delete-region (line-beginning-position -1) (line-beginning-position 1))
      (insert (format "\n;; %s  %g  %s %d\n"
                      (format-time-string "%Y-%m-%d")
                      sum
                      "Total sum of column"
                      column)))))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
