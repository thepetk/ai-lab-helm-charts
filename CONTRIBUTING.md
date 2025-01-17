# Contributing

## External Tools

You will need to have the following tools installed to generate README and JSON Schema files from their respective templates.

### Pre-Commit

Once this tool is installed you will need to run the `make install-pre-commit` to install the git pre-commit hook so that it will run and render the templates before you commit and push the changes in your pull request.

#### Description

Git hook scripts are useful for identifying simple issues before submission to code review. We run our hooks on every commit to automatically point out issues in code such as missing semicolons, trailing whitespace, and debug statements. By pointing these issues out before code review, this allows a code reviewer to focus on the architecture of a change while not wasting time with trivial style nitpicks.

#### Links

Website: [pre-commit.com](http://pre-commit.com/)  
Documentation: [pre-commit.com](http://pre-commit.com/)  
Example(s): [.pre-commit-config.yaml](https://github.com/backstage/charts/blob/main/.pre-commit-config.yaml)

### Helm-Docs

#### Description

The helm-docs tool auto-generates documentation from helm charts into markdown files. The resulting files contain metadata about their respective chart and a table with each of the chart's values, their defaults, and an optional description parsed from comments.
The markdown generation is entirely Go template driven. The tool parses metadata from charts and generates a number of sub-templates that can be referenced in a template file (by default README.md.gotmpl). If no template file is provided, the tool has a default internal template that will generate a reasonably formatted README.

#### Links

Repository: [norwoodj/helm-docs](https://github.com/norwoodj/helm-docs)  
Documentation: [README.md](https://github.com/norwoodj/helm-docs/blob/master/README.md)  
Example(s): [pre-commit-hook](https://github.com/backstage/charts/blob/main/.pre-commit-config.yaml#L2-L12)
