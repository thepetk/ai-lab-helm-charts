# AI Lab Helm Charts

This project is a collection of helm charts, insipired by the [AI Software Templates](https://github.com/redhat-ai-dev/ai-lab-template).

## Gitops

The gitops component, handled by ArgoCD for the RHDH case, is replaced by a Kubernetes Job created by the Helm chart, where this Job:

- Creates the GitHub repository for the application.
- Copies the application source code into the new repository.
- Copies the Tekton `PipelineRun` that builds new images for the application after pull requests merge or commits are pushed directly to the `main` branch.
  are merged and updates the Deployment of the application with the new version of the image by the PipelienRun directly patching the Deployment via `oc`, vs. ArgoCD using gitops to patch the Deployment.
- Commits these changes and pushes the commit to the preferred branch of the new repository.

The source code is [here](charts/ai-software-templates/chatbot/templates/application-gitops-job.yaml).

## OpenShift Pipelines

For OpenShift Pipelines configuration the two Helm charts provided are:

- The [Pipeline Install Helm Chart](/charts/ai-software-templates/pipeline-install) that makes Cluster Administrative level changes to OpenShift Pipelines to make sure that:
  - OpenShift Pipelines Operator is installed.
  - The correct Tekton Pipelines features are configured for our purposes.
  - The Pipelines As Code component is set up with the requisite credentials to process GitHub events for you GitHub Application.
- The [Pipeline Setup Helm Chart](/charts/ai-software-templates/pipeline-setup) that makes the User/Tenant changes in your application Namespace:
  - The Pipelines As Code PipelinesRuns in your Namespace have the requisite credentials to push your application's image to your Quay repository.
  - The [Gitops component](#gitops) has the requisite credentials to interact with the GitHub repository for your application.

The ai-lab helm charts exclusively uses tekton pipelines and tasks under [rhdh-pipelines](https://github.com/redhat-ai-dev/rhdh-pipelines) repo. The only customized resource used for the helm chart case is:

- The [.tekton/docker-push.yaml](/pac/pipelineRuns/.tekton/docker-push.yaml) PipelineRun used to manage `push` events received from the github app webhook.

## Testing with a Custom Helm Repository

To test your updates by importing the `ai-lab-helm-charts` fork as a custom Helm chart repository, you can follow the instructions [here](./docs/SETUP_CUSTOM_HELM_REPO.md)

## Release Process

The ai-lab-helm-charts are created on demand.

- A `tag` should be created with the version of the release as the name. `ai-lab-helm-charts` follows the v{major}.{minor}.{bugfix} format (e.g v0.1.0).
- Before proceeding, make sure that all the `version` fields within `Chart.yaml` have this tag as the value. For example in the case where the tag is `v0.1.0`, the `version` should be `0.1.0`.
- After the new release is published, the updated Helm packages will be pinned on the release.
