

# Chatbot AI Sample Helm Chart
![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

This Helm Chart deploys a Large Language Model (LLM)-enabled [chat bot application](https://github.com/redhat-ai-dev/ai-lab-samples/tree/main/chatbot).

## Background

This Helm Chart creates the following components:

### The Model Service
Based on the `llama.cpp` inference server and related to the [ai-lab-recipes model server](https://github.com/containers/ai-lab-recipes/tree/main/model_servers/llamacpp_python).

### The Application
A [Streamlit](https://github.com/streamlit/streamlit) application to interact with the model service which is based on the related [Chatbot Template](https://github.com/redhat-ai-dev/ai-lab-template/tree/main/templates/chatbot/content).

### The GitOps Job
A [job](./templates/application-gitops-job.yaml) which takes care of the creating the application github repository.

### The Tekton Repository
A [repository](./templates/tekton-repository.yaml) which connects our application with the `pipeline-as-code-controller` which allows us to manage all webhooks received from our GitHub Application.

## Prerequisites

- A [Github Application](https://github.com/redhat-ai-dev/ai-rhdh-installer/blob/main/docs/APP-SETUP.md#github-app) with `create repository` permissions for the GitHub Organization where the application will be created.
- Access to an OpenShift 4.x cluster with
    - permissions to deploy an application
	- an existing Namespace where your application will be deployed
	- correctly [installed](https://www.redhat.com/en/technologies/cloud-computing/openshift/pipelines) and [configured](https://github.com/redhat-ai-dev/ai-lab-helm-charts/blob/main/docs/PIPELINES_CONFIGURATION.md) OpenShift Pipelines Operator which is connected to your GitHub Applications webhook
	- a Secret (of `key/value` type) in the existing Namespace containing a [Github Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic) with [these permissions](https://github.com/redhat-ai-dev/ai-rhdh-installer/blob/main/docs/APP-SETUP.md#procedure) to the given Github Organization

## Installation

### Using the OpenShift Developer Catalog

This Helm Chart can be installed from the [Developer Catalog](https://docs.openshift.com/container-platform/4.17/applications/creating_applications/odc-creating-applications-using-developer-perspective.html#odc-using-the-developer-catalog-to-add-services-or-components_odc-creating-applications-using-developer-perspective) using the [OpenShift Developer Console](https://docs.openshift.com/container-platform/4.17/web_console/web-console-overview.html#about-developer-perspective_web-console-overview).

### Using the Helm Install Command

This Helm Chart can be installed via the command line by running the following command:

```
helm upgrade --install <release-name> --namespace <release-namespace> .
```

**NOTE:**
You can create a `private-values.yaml` file that will be ignored by git to pass values to your Helm Chart.
Just copy the existing `values.yaml` file in this directory to `private-values.yaml` and make any necessary edits, then update your installation command as shown below:

```shell
helm upgrade --install <release-name> --namespace <release-namespace> -f ./private-values.yaml .
```

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Red Hat AI Development Team |  | <https://github.com/redhat-ai-dev> |
## Source Code

* <https://github.com/redhat-ai-dev/ai-lab-template>
## Requirements

Kubernetes: `>= 1.27.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| application.appContainer | string | `"quay.io/redhat-ai-dev/chatbot:latest"` | The image used for the initial chatbot application interface |
| application.appPort | int | `8501` | The exposed port of the application |
| gitops.gitDefaultBranch | string | `"main"` | The default branch for the chatbot application Github repository |
| gitops.gitSecretKeyToken | string | `"GITHUB_TOKEN"` | The name of the Secret's key with the Github token value |
| gitops.gitSecretName | string | `"github-secrets"` | The name of the Secret containing the required Github token |
| gitops.gitSourceRepo | string | `"redhat-ai-dev/ai-lab-samples"` | The Github Repository with the contents of the ai-lab sample chatbot application |
| gitops.githubOrgName | string | `""` | [REQUIRED] The Github Organization name that the chatbot application repository will be created in |
| gitops.quayAccountName | string | `""` | [REQUIRED] The quay.io account that the application image will be pushed |
| model.dbRequired | bool | `false` | The bool variable for support of model database |
| model.existingModelServer | bool | `false` | The bool variable for support of existing model server |
| model.includeModelEndpointSecret | bool | `false` | The bool variable for support of bearer token authentication for existing model server authentication |
| model.initContainer | string | `"quay.io/redhat-ai-dev/granite-7b-lab:latest"` | The image used for the initContainer of the model service deployment |
| model.modelInitCommand | string | `"['/usr/bin/install', '/model/model.file', '/shared/']"` | The model service initContainer command |
| model.modelPath | string | `"/model/model.file"` | The path of the model file inside the model service container |
| model.modelServiceContainer | string | `"quay.io/ai-lab/llamacpp_python:latest"` | The image used for the model service |
| model.modelServicePort | int | `8001` | The exposed port of the model service |
| model.vllmSelected | bool | `false` | The bool variable for support of vllms |

**NOTE:** Your helm release's name will be used as the name of the application github repository
