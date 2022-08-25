---
title: Mirror to BitBucket GitHub Action
summary: GitHub Action to automatically mirror to BitBucket.
---


Mirrors a GitHub Git repository to BitBucket. If no corresponding BitBucket repository exists, it is created using the [BitBucket API 2.0](https://developer.atlassian.com/bitbucket/api/2/reference/).

**Please note**: make sure that you checkout the entire repository before using this. By default, `actions/checkout@v2` only creates a shallow clone. See section [example usage](#example-usage) on how to do a complete clone.

## Required Inputs

### `password`
Password to use on bitbucket for authentication and for pushing. **Create a new [App Password](https://bitbucket.org/account/settings/app-passwords/) with repository read and write permissions.**


## Optional Inputs
### `username`
Username to use on bitbucket for 1) authentication and as 2) workspace name. Default: GitHub user name.

### `repository`
Name of the repository on bitbucket. If it does not exist, it is created automatically. Default: GitHub repository name.

## Outputs
None


## Example usage

      - name: Checkout
        uses: actions/checkout@v2
        with:
          fetch-depth: 0 # <-- clone with complete history
      - name: Push
        uses: heussd/mirror-to-bitbucket-github-action@main
        id: mirror-to-bitbucket
        with:
          password: ${{ secrets.BITBUCKET_PASSWORD }}
