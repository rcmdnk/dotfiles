# Global Agent Configuration

## Time stamp
Show time stamp by using `date` command at the start and end of each session to track how long it takes for each agent to complete its tasks.
Show time stamp at the start and end of each agent's response to track how long it takes for each agent to complete its tasks.

## Git repository

### Commit & Pull Request Guidelines
- Write commit messages by English.
- Write commit subjects in the imperative mood with concise scopes (e.g., `feat: add pane drag overlay`). Scopes are:
  - feat: (new feature for the user, not a new feature for build script)
  - fix: (bug fix for the user, not a fix to a build script)
  - docs: (changes to the documentation)
  - style: (formatting, missing semi colons, etc; no production code change)
  - refactor: (refactoring production code, eg. renaming a variable)
  - test: (adding missing tests, refactoring tests; no production code change)
  - chore: (updating grunt tasks etc; no production code change)
- Group related changes together and avoid mixing formatting with feature work.
- When commits are warranted, proceed without waiting for explicit approval; communicate intent briefly when doing so.
- Describe user-facing impact in pull requests, referencing issue numbers when applicable.

### Using pre-commit/prek
- If your project uses Git for version control, commit your changes to a Git repository after making changes.
- If pre-commit/prek is installed in your environment, it will automatically run checks on your code before committing.
- If pre-commit/prek fails, address the issues it raises before attempting to commit again.

### Use gh to check GitHub status

- Use the `gh` command-line tool to check the status of your GitHub repository, including open pull requests and issues.
