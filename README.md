# Restricted GitHub Actions

This repository contains read-only workflows that can be dispatched by non-admins.

Suitable for tasks such as bypassing branch protection for automated tasks. In such cases, the action must be read-only to prevent misuse of sensitive access.

| Action | Dispatch type | Description |
|:-------|:--------------|:------------|
| [Sync primary branches on PocketMine-MP](https://github.com/pmmp/RestrictedActions/actions/workflows/pocketmine-mp-branch-sync.yml) | Manual | Performs a simple git merge for PocketMine-MP's primary dev branches.<br>Note: this action won't fix conflicts. Conflicts must be resolved by a human and PR'd manually. |
| [PocketMine-MP privileged post-commit actions](https://github.com/pmmp/RestrictedActions/actions/workflows/pocketmine-mp-post-release.yml) | Automatic | Bumps PocketMine-MP version and sets `IS_DEVELOPMENT_BUILD` back to `true` after a release |
