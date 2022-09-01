# SALT

**run highstate -- update all salt members**</br>
`salt \* state.highstate`

**run highstate for minions named \*sensor\***</br>
`salt \*sensor\* state.highstate`

**remove minion from salt grid**</br>
`salt-key -d \*sensor\*`
