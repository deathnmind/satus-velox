# SSH Things

**remove specific line from known-hosts -- 2 for example**</br>
`sed -i '2d' ~/.ssh/known_hosts`

**find the SSH2 SHA256 key passed from a ssh public key**  
`ssh-keygen -lf ./id_rsa.pub`
