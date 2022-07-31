# Visual Studio Code

- select all items: use find in VSCode - then `Alt+Enter` to all matching items for the pattern
- Regex to find duplicates: `^(.*)(\n\1)+$`
- Edit all lines - `Ctrl+A` and then - `Alt+Shift+I` to edit all lines
  - after editing all lines can use home/end to move to begining or end of all lines for typing/deleting
- Point RemoteSSH Extension to WSL `~/.ssh/files`
  - SSH: Config File -> RemoteSSH Settings -> Extensions -> RemoteSSH -> RemoteSSH Config File
  - add path: `//wsl$/Ubuntu-20.04/home/name/.ssh/config`

## Keyboard Shortcuts

- `Ctrl+Shift+K` - deletes line
- `Alt+Enter` - select all items found
- `Alt+Shift+I` - edit multiple selected lines  

### Install Extensions via command line

- `code --install-extension {extension_identifier}`
