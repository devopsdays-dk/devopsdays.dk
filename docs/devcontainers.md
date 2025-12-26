# Devcontainers

This repo has two devcontainer:

- [Ruby — from dockerfile](../.devcontainer/ruby/devcontainer.json)
- [Ubuntu — from Noble image](../.devcontainer/ubuntu/devcontainer.json)

The both share the same [`postCreateCommand.sh`](../.devcontainer/postCreateCommand.sh). They follow different paths to get you to the same places, the Ruby one is superior in performance, but the Ubuntu one is less complex and probably easier to read. They are both included to allow you to explore two quite different approaches.


