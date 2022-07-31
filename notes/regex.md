# Regex - oh boy

## This is not exhuastive

- Works for and IP Address - but gets other things too `\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b`
  - Non-greedy: `?` makes the regular expression non-greedy and will end at `?`
  - for example: `\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b` will match `123.123.123.123,443`
  - add non-greedy to drop port: `\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3?}\b`
