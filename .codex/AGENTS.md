# Global Agent Configuration

## Git repository

### Commit & Pull Request Guidelines
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

### Using pre-commit
- If your project uses Git for version control, commit your changes to a Git repository after making changes.
- If pre-commit is installed in your environment, it will automatically run checks on your code before committing.
- If pre-commit fails, address the issues it raises before attempting to commit again.

## Code editing
- When editing code that depends on external libraries, use Context7 to check the latest official library documentation before implementing changes.
