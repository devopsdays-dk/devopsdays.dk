# GitHub CLI Authentication in Codespaces

## Problem

GitHub Codespaces automatically injects a `GITHUB_TOKEN` environment variable containing a `ghu_***` (GitHub User) token but with some limited permissions. This token does **not** include `project:write` scope, which may be required by `devx-cafe/gh-tt` (if a `project` node is  defined in .tt_config).

If that is the case you need to setup a different token with project permissions.

## Token Precedence in gh CLI

GitHub tokens can be defined in different places. The gh CLI uses a specific precedence order to determine which one to use. The first one found is used

The gh CLI checks for authentication in this order:

1. **`GH_TOKEN`** environment variable (highest priority)
2. **`GITHUB_TOKEN`** environment variable
3. Stored credentials in **`~/.config/gh/hosts.yml`** (lowest priority)

## Solution

Use an OAuth Token (`gho_***`) with `project:write` permissions and make it available as the `GH_TOKEN` environment variable throughout all terminal sessions in your Codespace.

### Step 1: Create a GitHub OAuth Token

If you don't already have a Personal Access Token (gho) with the required permissions, create one:

```bash
# Use GitHub's web-based auth flow to create a token with project access
unset GITHUB_TOKEN  && unset GITHUB_TOKEN #make sure the token is not eclipsed
gh auth login -s project
```

This will prompt you for authentication and create a token with `project:write` scope and other necessary permissions.

### Step 2: Store Token as a Codespaces Secret

Once you have the token, retrieve it and store it as a Codespaces secret:

```bash
# Get the token
gh auth token
```

Copy the token (starts with `gho_`) and store it as a **Codespaces secret** named `GH_TOKEN`:

- Go to https://github.com/settings/codespaces
- Under "Secrets", create a new secret named `GH_TOKEN`
- Paste your token value

### Step 3: Rebuild Your Codespace

Rebuild your Codespace to pick up the new secret. The `postCreateCommand.sh` will detect `GH_TOKEN` and use it automatically.

## Verification

After restarting your Codespace, verify that `GH_TOKEN` is set and takes precedence:

```bash
echo $GH_TOKEN
gh auth status
```

The output should show:

- `GH_TOKEN` is set to your gho token (starting with `gho_`)
- Authentication with your GitHub account using the `GH_TOKEN`
- Required scopes including `project`, `repo`, `workflow`, `gist`, and `read:org`

Example successful output:

```bash
github.com
  ✓ Logged in to github.com account <your-username> (GH_TOKEN)
  - Active account: true
  - Git operations protocol: https
  - Token: gho_************************************
  - Token scopes: 'gist', 'project', 'read:org', 'repo', 'workflow'
```

## Related Tools

This setup is particularly important for tools that require project write permissions, such as:

- `devx-cafe/gh-tt` - GitHub Project task management

These tools will now have the necessary permissions to interact with GitHub Projects in your Codespace.
