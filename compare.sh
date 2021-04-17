#!/usr/bin/env bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 readme bookmarks ignores"
    exit 1
fi

  diff <(sort <(sed -n -r 's/- \[[^]]*\]\(\s*([^)]*)\s*\).*$/\1/p' "$1")) <(grep -F -x -v -f "$3" <(sort "$2"))
 
# diff                                                                                                          take the `diff` of
#      <(                                                               )                                          the process substitution of
#        sort <(                                                       )                                              the `sort` output of
#               sed                                                                                                      the `sed` output where
#                   -n                                                                                                      default printing is suppressed
#                      -r                                                                                                   extended mode is enabled
#                         's                                     '                                                          substitution is performed on the following pattern consisting of
#                           /-                                                                                                 a literal hyphen
#                              \[     \]                                                                                       with the following enclosed by `md` URL text brackets
#                                [^]]*                                                                                            0 or more non-"closing-square-brackets"
#                                       \(             \)                                                                      with the following enclosed by `md` URL hyperlink parentheses:
#                                         \s*                                                                                     0 or more instances of any whitespace
#                                            (     )                                                                           with the following as a capture group (1)
#                                             [^)]*                                                                               0 or more non-closing-"parentheses"
#                                                   \s*                                                                        followed by any amount of whitespace
#                                                        .*$                                                                   followed by everything until the end of the line
#                                                           /                                                               which is replaced by
#                                                            \1                                                                the first capture group (being the URL)
#                                                              /                                                            with the following options
#                                                               p                                                              print the addressed line(s)
#                                                                                                                           on
#                                                                  "$1"                                                     param `$1` (the README file)
#                                                                                                                  and
#                                                                         <(                                  )    the process substitution of
#                                                                           grep                                      the `grep` output where
#                                                                                -F                                      a literal string is used as a pattern
#                                                                                   -x                                   on the whole line
#                                                                                      -v                                only matching the negation
#                                                                                         -f                             using files as input
#                                                                                                                     using
#                                                                                            "$3"                     param `$3` (the ignored URLs file)
#                                                                                                                     and
#                                                                                                 <(         )        the process substitution of
#                                                                                                   sort              the `sort` output
#                                                                                                                     using
#                                                                                                        "$2"         param `$2` (the internal bookmarks file)
