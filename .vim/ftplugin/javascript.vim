" Only do this when not done yet for this buffer
if exists("b:did_ftplugin") || exists("loaded_xmledit")
  finish
endif
" Some custom settings according to the coding standards of a few guys around
" here
setlocal shiftwidth=2
setlocal softtabstop=2
"}}}1
finish
