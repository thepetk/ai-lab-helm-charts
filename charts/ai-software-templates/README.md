## ai-software-templates

Apart from the [pipeline-install](./pipeline-install/) and the [pipeline-setup](./pipeline-setup/) which are tools to help you install the Tekton Pipelines along with your charts, the rest of charts under this directory are based on the [redhat-ai-dev/ai-lab-app](https://github.com/redhat-ai-dev/ai-lab-app) gitops resources repo.

### Pull automatically latest changes

To pull all the latest changes for the charts from the `ai-lab-app` repository you can simply run the `generate.sh` script placed in the root dir of this repository.

The script will clone the `ai-lab-app` and will convert the necessary resources to helm chart template files. Each chart has a corresponding `env` file under `scripts/envs` dir which helps us configure the behavior of the conversion process.
