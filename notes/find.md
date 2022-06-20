**text within file name**  
`find ./ -iname "*text*"`

**find file modified between dates provide**  
`find  . -type f -newermt "2020-01-01" \! -newermt "2020-01-01" | xargs`

**find files larger then a given size**  
`find ./ -type f -size +4G` 

**find and delete empty directories**  
`find ./ -empty -type d -delete`  
