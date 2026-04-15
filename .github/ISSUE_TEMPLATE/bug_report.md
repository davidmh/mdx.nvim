---
name: Bug report
about: Create a report to help us improve
title: ''
labels: bug
assignee: ''

---

## Description
<!-- A clear and concise description of what the bug is -->

## Steps to Reproduce
1.
2.
3.

## Expected behavior
<!-- What you expected to happen -->

## Actual behavior
<!-- What actually happened instead -->

## Minimal reproduction

Please first try to reproduce the issue with the minimal config:

```bash
# Clone and enter this repository first.

# Clean up any existing local data
rm -rf .local/

# Run the setup script
./setup-minimal-config

# Open the test file
nvim -u minimal-init.lua test.mdx
```

Does the issue reproduce with the minimal config?

## Additional context
<!-- Add any other context about the problem here -->
