## Release:

- [ ] To create a release, I will create a PR from `develop` to `main` with an incremented version in Chart.yaml
    - Internally, we rely on [chart-releaser](https://github.com/helm/chart-releaser-action) to automatically update the index.yaml on the `gh-pages` branch on version updates.
- [ ] I will **squash and merge** this branch if merging to `develop`
- [ ] I will **commit merge** this branch if merging to `main`