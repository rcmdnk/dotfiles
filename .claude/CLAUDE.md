# Global Agent Configuration

## Timestamp

- Show a timestamp by running the `date` command at the start and end of each session to track how long each agent takes to complete its tasks.
- Show a timestamp at the start and end of each agent's response to track how long each agent takes to complete its tasks.

## Message format

- Do not use emoji or special characters in either terminal output or text output.

## Git repository

### Commit & Pull Request Guidelines

- Write commit messages in English.
- If the contextual-commit skill is available, use the skill to format the commit message.
- Otherwise, write commit subjects in the imperative mood with concise scopes (e.g., `feat: add pane drag overlay`). Scopes are:
    - feat: (new feature for the user, not a new feature for the build script)
    - fix: (bug fix for the user, not a fix for the build script)
    - docs: (changes to the documentation)
    - style: (formatting, missing semicolons, etc.; no production code change)
    - refactor: (refactoring production code, e.g., renaming a variable)
    - test: (adding missing tests, refactoring tests; no production code change)
    - chore: (updating grunt tasks, etc.; no production code change)
- Do not add claude session IDs or cluade related metadata to commit messages.
- Group related changes together and avoid mixing formatting with feature work.
- When commits are warranted, proceed without waiting for explicit approval; communicate intent briefly when doing so.
- Describe user-facing impact in pull requests, referencing issue numbers when applicable.

### Using pre-commit/prek
- If your project uses Git for version control, commit your changes to a Git repository after making changes.
- If pre-commit/prek is installed in your environment, it will automatically run checks on your code before committing.
- If pre-commit/prek fails, address the issues it raises before attempting to commit again.

### Use gh to check GitHub status

- Use the `gh` command-line tool to check the status of your GitHub repository, including open pull requests and issues.

### Use worktree to manage branches

- Worktrees must be created under the `.worktree/` directory, and the branch name must match the worktree name.
- If multiple agents are working on the same repository, each agent should create a separate worktree to avoid conflicts.

## Review Procedure for Substantial Work

When you finish a substantial unit of work (a feature, a non-trivial bug fix, a multi-file refactor, a security-sensitive change), and whenever you produce a plan or design, you MUST invoke the `codex-review` skill and follow it before declaring the task complete or committing. This does not apply to trivial edits such as typo fixes, single-line tweaks, or minor wording adjustments.

This gate fails closed. If the `codex-review` skill is not available, run the companion script directly from inside the git repo instead — `node ~/.claude/plugins/cache/openai-codex/codex/*/scripts/codex-companion.mjs review ""`, plus `adversarial-review ""` for plans/designs and for changes touching security, permissions, data integrity, external APIs, or agent automation scope. Handle every item returned: apply it, or tell the user why you did not. If the script is missing too, say so and skip the step — never fabricate review results.
