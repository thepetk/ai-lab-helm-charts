##@ Generation

.PHONY: generate
generate: ## Run all generation commands
	pre-commit run --all-files

.PHONY: helm-docs
helm-docs: ## Generate README.md from the README.md.gotmpl file
	pre-commit run helm-docs --all-files

.PHONY: jsonschema-dereference
jsonschema-dereference: ## Generate values.schema.json from the values.schema.tmpl.json file
	pre-commit run jsonschema-dereference --all-files

##@ Scripts	

.PHONY: install-pre-commit
install-pre-commit: ## Install the pre-commit script
	pre-commit install

##@ General

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk command is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
