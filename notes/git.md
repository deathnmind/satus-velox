# Working with GIT

## Authentication

**Set Global email**: `git config --global user.email "user@email.com"`  
**Set Global username**: `git config --global user.name "user"`  
**Next time personal access token used it will be saved**: `git config --global credential.helper store`  

## Remove sensitive files

[Github Refrence](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository).  
[BFG Repo Cleaner](https://rtyley.github.io/bfg-repo-cleaner/).

```bash
git clone --mirror https://github.com/repository/project
java -jar ./bfg-1.14.0.jar --delete-files sensitive.txt project.git
cd project.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push --force
```

## Adding a local repository to GitHub with GitHub CLI

- In the command line, navigate to the root directory of your project.
- Initialize the local directory as a Git repository.

```
 git init -b main
```

- Stage and commit all the files in your project

```
  git add . && git commit -m "initial commit"
```

- To create a repository for your project on GitHub, use the `gh repo create` subcommand. When prompted, select Push an existing local repository to GitHub and enter the desired name for your repository. If you want your project to belong to an organization instead of your user account, specify the organization name and project name with organization-name/project-name.
- Use personal access token for authentication - must have read:org permissions
- Once through gh repo create run again after authentication to create and name the new repository

---

## GitTea

```bash
git clone ssh://git@127.0.0.1:222/user/repository.git 
cd ./repository 
git add .
git config user.email "user@email.local" 
git config user.name "user" 
git commit -a
git push origin master
```

### Enable searching with in repositories on Gitea

- Edit `app.ini` add the indexing lines
- `MAX_FILE_SIZE` indicates the maximum file size the indexer will scan

```
[indexer]
; ...
REPO_INDEXER_ENABLED = true
REPO_INDEXER_PATH = indexers/repos.bleve
UPDATE_BUFFER_LEN = 20
MAX_FILE_SIZE = 209715200
REPO_INDEXER_INCLUDE =
REPO_INDEXER_EXCLUDE = resources/bin/**
```

---

### Automatically preform GIT option after commit in VS Code

In VS Code - **File** > **Preferences** > **Settings** -- search post commit... Change to desired git operation after successful commit. I set it to push.
