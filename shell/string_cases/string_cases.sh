#https://www.shellscript.sh/tips/case/

firstname='sOng'
firstname=${firstname^} # SOng
firstname=${firstname,} # sOng
firstname=${firstname,,} # song
firstname=${firstname^^} # SONG

# typeset -u only show, but actually is still lower
