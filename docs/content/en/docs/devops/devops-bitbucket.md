---
hide:
  - tags
tags:
  - Bitbucket
---

# Bitbucket

## Workflow

### Create A Branch Locally

1. List the branches on your repository

   ```sh
   git branch
   ```

   The output is similar to this:

   ```sh
   * master
   (END)
   ```

   Press `q` to return to the terminal

2. Create a new feature branch in the repository

   ```sh
   git branch bein-sandbox-kube-base
   ```

3. Switch to the feature branch to work on it

   ```sh
   git checkout bein-sandbox-kube-base
   ```

   The output is similar to this:

   ```sh
   Switched to branch 'bein-sandbox-kube-base'
   ```

4. Commit the change(s) to the feature branch

   ```sh
   git add -A
   git commit -m "Added a change from the feature branch"
   ```

   The output is similar to this:

   ```sh
   On branch bein-sandbox-kube-base
   nothing to commit, working tree clean
   ```

5. Switch back to the `master` branch

   ```sh
   git checkout master
   ```

   The output is similar to this:

   ```sh
   Switched to branch 'master'
   Your branch is up to date with 'origin/master'.
   ```

6. Switch back to the `master` branch

   ```sh
   git push origin bein-sandbox-kube-base
   ```

   The output is similar to this:

   ```sh
   Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
   remote:
   remote: Create pull request for bein-sandbox-kube-base:
   remote:   https://bitbucket.org/nhamchanvi/bein-kube-base/pull-requests/new?source=bein-sandbox-kube-base&t=1
   remote:
   To bitbucket.org:nhamchanvi/bein-kube-base.git
    * [new branch]      bein-sandbox-kube-base -> bein-sandbox-kube-base
   ```

### Branch Permission

### Branching Model

## Whatsnext

<!-- provide a bulleted list of topics (5 maximum) to learn more about the concept. -->

```

```
