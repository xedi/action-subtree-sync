This action synchronizes a subtree split-repository with it's parent.

It's primary use is to create a split branch and push it to the parent, then tag it.

The action requires the following inputs:

Key | Description
--- | ---
`subtree` | Subtree repository name (including owner)
`subtree_deploy_key` | A public key part of a Deploy Key on the subtree repository
`split_prefix` | The directory to perform the split on

As described above you will need to create a Deploy Key, place the the private part in the Deploy Key settings of the subtree repository; and the public part in the Secrets settings of the parent repository.

## Example usage

```yaml
name: Release Subtree

on:
  push:
    tags:
      - '*'

jobs:
  checkout:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v1
  release:
    runs-on: ubuntu-latest
    needs: checkout
    steps:
      - name: Release
        uses: xedi/action-subtree-sync@1.0.0
        with:
          subtree: 'owner/repository'
          subtree_deploy_key: ${{ secrets.DEPLOY_KEY }}
          split_prefix: 'src/directory'
```
