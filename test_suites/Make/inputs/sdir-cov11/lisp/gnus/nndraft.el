;;; nndraft.el --- draft article access for Gnus
;; Copyright (C) 1995,96,97,98 Free Software Foundation, Inc.

;; Author: Lars Magne Ingebrigtsen <larsi@gnus.org>
;; Keywords: news

;; This file is part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;; Code:

(require 'nnheader)
(require 'nnmail)
(require 'gnus-start)
(require 'nnmh)
(require 'nnoo)
(eval-when-compile
  (require 'cl)
  ;; This is just to shut up the byte-compiler.
  (fset 'nndraft-request-group 'ignore))

(nnoo-declare nndraft
  nnmh)

(defvoo nndraft-directory (nnheader-concat gnus-directory "drafts/")
  "Where nndraft will store its files."
  nnmh-directory)



(defvoo nndraft-current-group "" nil nnmh-current-group)
(defvoo nndraft-get-new-mail nil nil nnmh-get-new-mail)
(defvoo nndraft-current-directory nil nil nnmh-current-directory)

(defconst nndraft-version "nndraft 1.0")
(defvoo nndraft-status-string "" nil nnmh-status-string)



;;; Interface functions.

(nnoo-define-basics nndraft)

(deffoo nndraft-open-server (server &optional defs)
  (nnoo-change-server 'nndraft server defs)
  (cond
   ((not (file-exists-p nndraft-directory))
    (nndraft-close-server)
    (nnheader-report 'nndraft "No such file or directory: %s"
		     nndraft-directory))
   ((not (file-directory-p (file-truename nndraft-directory)))
    (nndraft-close-server)
    (nnheader-report 'nndraft "Not a directory: %s" nndraft-directory))
   (t
    (nnheader-report 'nndraft "Opened server %s using directory %s"
		     server nndraft-directory)
    t)))

(deffoo nndraft-retrieve-headers (articles &optional group server fetch-old)
  (nndraft-possibly-change-group group)
  (save-excursion
    (set-buffer nntp-server-buffer)
    (erase-buffer)
    (let* ((buf (get-buffer-create " *draft headers*"))
	   article)
      (set-buffer buf)
      (buffer-disable-undo (current-buffer))
      (erase-buffer)
      ;; We don't support fetching by Message-ID.
      (if (stringp (car articles))
	  'headers
	(while articles
	  (set-buffer buf)
	  (when (nndraft-request-article
		 (setq article (pop articles)) group server (current-buffer))
	    (goto-char (point-min))
	    (if (search-forward "\n\n" nil t)
		(forward-line -1)
	      (goto-char (point-max)))
	    (delete-region (point) (point-max))
	    (set-buffer nntp-server-buffer)
	    (goto-char (point-max))
	    (insert (format "221 %d Article retrieved.\n" article))
	    (insert-buffer-substring buf)
	    (insert ".\n")))

	(nnheader-fold-continuation-lines)
	'headers))))

(deffoo nndraft-request-article (id &optional group server buffer)
  (nndraft-possibly-change-group group)
  (when (numberp id)
    ;; We get the newest file of the auto-saved file and the
    ;; "real" file.
    (let* ((file (nndraft-article-filename id))
	   (auto (nndraft-auto-save-file-name file))
	   (newest (if (file-newer-than-file-p file auto) file auto))
	   (nntp-server-buffer (or buffer nntp-server-buffer)))
      (when (and (file-exists-p newest)
		 (nnmail-find-file newest))
	(save-excursion
	  (set-buffer nntp-server-buffer)
	  (goto-char (point-min))
	  ;; If there's a mail header separator in this file,
	  ;; we remove it.
	  (when (re-search-forward
		 (concat "^" mail-header-separator "$") nil t)
	    (replace-match "" t t)))
	t))))

(deffoo nndraft-request-restore-buffer (article &optional group server)
  "Request a new buffer that is restored to the state of ARTICLE."
  (nndraft-possibly-change-group group)
  (when (nndraft-request-article article group server (current-buffer))
    (message-remove-header "xref")
    (message-remove-header "lines")
    t))

(deffoo nndraft-request-update-info (group info &optional server)
  (nndraft-possibly-change-group group)
  (gnus-info-set-read
   info
   (gnus-update-read-articles (gnus-group-prefixed-name group '(nndraft ""))
			      (nndraft-articles) t))
  (let (marks)
    (when (setq marks (nth 3 info))
      (setcar (nthcdr 3 info)
	      (if (assq 'unsend marks)
		  (list (assq 'unsend marks))
		nil))))
  t)

(deffoo nndraft-request-associate-buffer (group)
  "Associate the current buffer with some article in the draft group."
  (nndraft-open-server "")
  (nndraft-request-group group)
  (nndraft-possibly-change-group group)
  (let ((gnus-verbose-backends nil)
	(buf (current-buffer))
	 article file)
    (nnheader-temp-write nil
      (insert-buffer buf)
      (setq article (nndraft-request-accept-article
		     group (nnoo-current-server 'nndraft) t 'noinsert))
      (setq file (nndraft-article-filename article)))
    (setq buffer-file-name (expand-file-name file))
    (setq buffer-auto-save-file-name (make-auto-save-file-name))
    (clear-visited-file-modtime)
    article))

(deffoo nndraft-request-expire-articles (articles group &optional server force)
  (nndraft-possibly-change-group group)
  (let* ((nnmh-allow-delete-final t)
	 (res (nnoo-parent-function 'nndraft
				    'nnmh-request-expire-articles
				    (list articles group server force)))
	 article)
    ;; Delete all the "state" files of articles that have been expired.
    (while articles
      (unless (memq (setq article (pop articles)) res)
	(let ((auto (nndraft-auto-save-file-name
		     (nndraft-article-filename article))))
	  (when (file-exists-p auto)
	    (funcall nnmail-delete-file-function auto)))))
    res))

(deffoo nndraft-request-accept-article (group &optional server last noinsert)
  (nndraft-possibly-change-group group)
  (let ((gnus-verbose-backends nil))
    (nnoo-parent-function 'nndraft 'nnmh-request-accept-article
			  (list group server last noinsert))))

(deffoo nndraft-request-create-group (group &optional server args)
  (nndraft-possibly-change-group group)
  (if (file-exists-p nndraft-current-directory)
      (if (file-directory-p nndraft-current-directory)
	  t
	nil)
    (condition-case ()
	(progn
	  (gnus-make-directory nndraft-current-directory)
	  t)
      (file-error nil))))


;;; Low-Level Interface

(defun nndraft-possibly-change-group (group)
  (when (and group
	     (not (equal group nndraft-current-group)))
    (nndraft-open-server "")
    (setq nndraft-current-group group)
    (setq nndraft-current-directory
	  (nnheader-concat nndraft-directory group))))

(defun nndraft-article-filename (article &rest args)
  (apply 'concat
	 (file-name-as-directory nndraft-current-directory)
	 (int-to-string article)
	 args))

(defun nndraft-auto-save-file-name (file)
  (save-excursion
    (prog1
	(progn
	  (set-buffer (get-buffer-create " *draft tmp*"))
	  (setq buffer-file-name file)
	  (make-auto-save-file-name))
      (kill-buffer (current-buffer)))))

(defun nndraft-articles ()
  "Return the list of messages in the group."
  (gnus-make-directory nndraft-current-directory)
  (sort
   (mapcar 'string-to-int
	   (directory-files nndraft-current-directory nil "\\`[0-9]+\\'" t))
   '<))

(nnoo-import nndraft
  (nnmh
   nnmh-retrieve-headers
   nnmh-request-group
   nnmh-close-group
   nnmh-request-list 
   nnmh-request-newsgroups
   nnmh-request-move-article
   nnmh-request-replace-article))

(provide 'nndraft)

;;; nndraft.el ends here
