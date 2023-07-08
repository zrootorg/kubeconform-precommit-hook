# Kubeconform pre-commit hook

Use kubeconform as a [pre-commit](https://pre-commit.com/) hook.

## Usage

```yaml
- repo: https.//github.com/zrootorg/kubeconform-precommit-hook
  rev: main
  hooks:
    - id: kubeconform
      args:
        - --path=./kubernetes
```
