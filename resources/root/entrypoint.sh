#!/bin/sh -l

# Key scan for github.com
ssh-keyscan github.com > /root/.ssh/known_hosts

# Set ssh key for subtree
echo "${INPUT_SUBTREE_DEPLOY_KEY}" >> /root/.ssh/subtree
chmod 0600 /root/.ssh/subtree

# Get subtree repository into split directory
git clone subtree:"${INPUT_SUBTREE}" /tmp/split --bare

# Create the subtree split branch
git subtree split --prefix="${INPUT_SPLIT_PREFIX}" --squash -b split
# Push to the subtree directory
git push /tmp/split split:master

cd /tmp/split
git push -u origin master

# Tag the subtree repository
git tag $(basename "${GITHUB_REF}")
git push --tags

# DUN
