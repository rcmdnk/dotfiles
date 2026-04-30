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

### Use worktree to manage branches

- worktree must be created in .worktree/ directory, and the branch name must be the same as the worktree name.
- If multiple agents are working on the same repository, each agent should create a separate worktree to avoid conflicts.

## Review Procedure for Substantial Work

When you finish a substantial unit of work (a feature, a non-trivial bug fix, a refactor that spans multiple files, changes to security-sensitive code, etc.), the following steps MUST be performed before declaring the task complete or committing. They do not apply to trivial edits such as typo fixes, single-line tweaks, or minor wording adjustments.

1. **Run the Codex review**
   - After completing the work, invoke the Codex companion script directly via Bash from inside the relevant git repository:
     ```bash
     node ~/.claude/plugins/cache/openai-codex/codex/*/scripts/codex-companion.mjs review ""
     ```
     (The `*` resolves to whatever plugin version is currently installed. The script must be run from inside a git repo; `cd` there first if needed.)
   - Do not ignore the feedback returned. Each item must be handled in one of two ways:
     - Valid feedback → update the code/work to reflect it.
     - Feedback you choose not to apply → briefly tell the user why before moving on.
   - If you made fixes in response to the review, re-run the same command to confirm the issues are resolved.

2. **Run the Codex adversarial review**
   - **Always** run the adversarial review whenever a plan or design is produced — for example, after preparing an implementation plan, an architecture proposal, a migration strategy, or any other forward-looking design (including output from plan mode or planning agents). Treat the plan itself as the review target before any code is written.
   - Also run it after the work is complete if the change can affect security, permissions, authentication/authorization, data integrity, external-facing APIs, agent automation scope, or other high-impact surfaces.
   - Invoke it the same way:
     ```bash
     node ~/.claude/plugins/cache/openai-codex/codex/*/scripts/codex-companion.mjs adversarial-review ""
     ```
   - For each surfaced risk (misuse, abuse vectors, rule conflicts, runaway behavior, edge-case failures, etc.), either reflect a mitigation in the plan/code (input validation, guard clauses, narrowed scope, revised approach, etc.) or, if you do not address it, explain the reasoning to the user.

3. **Confirm before committing**
   - Commit only after the review feedback has been handled. Use the appropriate Conventional Commits scope (`feat:`, `fix:`, `refactor:`, etc.).

Note: if the codex-companion script is not present (the codex plugin is not installed in this environment), tell the user and skip the step rather than fabricating results.
