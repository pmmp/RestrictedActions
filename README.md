# Restricted GitHub Actions

Contains actions that can be triggered by non-admins, but that require admin permissions to perform their tasks.

To prevent misuse of admin access, these workflows are editable only by admins.

| Action | Dispatch type | Description |
|:-------|:--------------|:------------|
| [Sync primary branches on PocketMine-MP](https://github.com/pmmp/RestrictedActions/actions/workflows/pocketmine-mp-branch-sync.yml) | Manual | Performs a simple git merge for PocketMine-MP's primary dev branches.<br>Note: this action won't fix conflicts. Conflicts must be resolved by a human and PR'd manually. |
| [PocketMine-MP privileged post-commit actions](https://github.com/pmmp/RestrictedActions/actions/workflows/pocketmine-mp-post-release.yml) | Automatic | Bumps PocketMine-MP version and sets `IS_DEVELOPMENT_BUILD` back to `true` after a release |
| [Auto approve collaborator PRs](https://github.com/pmmp/RestrictedActions/actions/workflows/auto-approve-collaborator-pr.yml) | Automatic | Approves collaborator PRs to reduce the number of approvals needed to meet merge requirements |
