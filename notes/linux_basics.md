# Linux Command Line Primer #

- Archive commands
  - TAR Options:
    - `x` - extract
    - `f` - file
    - `v` - verbose
    - `c` - compress
    - `z` - gzip - create/extract tgz files
    - `t` - view contents
    - `j` - bzip2 - create/extract bzip2 files
    - `r` - append or update files or directories to existing archive
  - untar single file from archive - `tar -xvf tar_file.tar file1.txt`
  - extract to a new directory: `tar -xf tar_file.tar -C /new/path`
    - alternatively: `tar -xf tar_file.tar --directory /new/path`
    - also: `tar -C /new/path -xzvf tar_file.tar`
  - create archive in a different path: `tar -czvf /path/to/tar_file.tgz ./folder_to_archive/`
  - **Not need cause TAR can manipulate these**
    - bzip2
      - not installed in base Ubuntu
      - expand: `bzip2 -dk filename.bz2`
    - gunzip
      - expand: `gunzip file.tar.gz`  

- WTMP File
  - Commands to display information from wtmp log (sucessful logins)
    - `last` - display all records
    - `last -5` - last 5 records
    - `last -R` - no host resolution
      - `-s` - select records by date begining
      - `-t` - records end date
      - `last -R -s -2days -t -1days` - relative dates work
      - `last -R -s 2020-07-01 11:00 -t 2020-07-01 20:00` - specific dates & time
  - BTMP
    - failed logins - including ssh
    - `lastb -R` - return with no host resolution
    - `last` options work with `lastb`

- Symbolic links
  - create a sybolic link - source to destination - destination is created by command
  - `ln -s /mnt/d/ ./local_d  
  
- LS Command
  - `ls -lat` - sort by modification time
  - `ls -Artls` - sorted newest first
  - `ls -la --time=atime` - sort by access time

- WGET
  - `wget --recursive` - recursive get site files
  - `wget -U "user_agent"` - change the user agent string
  - `wget --user-agent 'user_agent'` - alternate user agent change
  - `wget -O {new} {url}` - save file under a different name
  - `wget -P {specific path} {url}` - get specific directory
  - `wget -c {remote_file}` - resume download if supported
  - `wget -b {remote_file}` - download in background
  - `wget --content-disposition` - used by a server to suggest a filename for downloaded file
  - `wget -O` - send wget to standard out (screen)

- SED - substitution
  - `sed -i 's/term1/term2/g' file.txt` - globally replaced term1 with term2 in file.txt
  - `sed -i 's/term1/term2' file.txt` - will only change first instance - not globally
