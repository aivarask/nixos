echo 'ETC'

for buf in getbufinfo()
  echo buf.name
endfor
for buf in getbufinfo({'buflisted':1})
  if buf.changed
    echo 'bufchanged'
  endif
endfor
