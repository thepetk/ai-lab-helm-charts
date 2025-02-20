

# Model Server Sample Helm Chart
![Version: 0.1.6](https://img.shields.io/badge/Version-0.1.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

This Helm Chart deploys a model server. While no application is configured, this model server can be utilized in other applications.

## Background

This Helm Chart creates the following components:

### The Model Service
By default the `model-server` uses the `llama.cpp` inference via the [ai-lab-recipes model server](https://github.com/containers/ai-lab-recipes/tree/main/model_servers/llamacpp_python).

For the `vLLM` model service case, the `Values.model.vllmSelected` value should be `true`, the `Values.model.vllmModelServiceContainer` and the `Values.model.modelName` should be configured too.

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
| model.initContainer | string | `"quay.io/redhat-ai-dev/granite-7b-lab:latest"` | The image used for the initContainer of the model service deployment |
| model.maxModelLength | int | `4096` | The maximum sequence length of the model. It is used only for the vllm case and the default value is 4096. |
| model.modelInitCommand | string | `"['/usr/bin/install', '/model/model.file', '/shared/']"` | The model service initContainer command |
| model.modelName | string | `""` | The name of the model. It is used only in the vLLM use case. |
| model.modelPath | string | `"/model/model.file"` | The path of the model file inside the model service container |
| model.modelServiceContainer | string | `"quay.io/ai-lab/llamacpp_python:latest"` | The image used for the model service. For the VLLM case please see vllmModelServiceContainer |
| model.modelServicePort | int | `8001` | The exposed port of the model service |
| model.vllmModelServiceContainer | string | `""` | The image used for the model service for the vLLM use case. |
| model.vllmSelected | bool | `false` | Adds support of vLLM instead of llama_cpp. Be sure that your system has GPU support for this case. |

**NOTE:** Your helm release's name will be used as the name of the application github repository
