# FAIRVASC Federated Sandbox

This is a research sandbox to implement various ideas for federating the specific setup used in the [Fairvasc.eu](https://fairvasc.eu/) project.
You can run the models and simulate a registry setup without leaving your browser by using the custom Github Codespaces environment (see below).

## SPARQL Sandbox

Most of these federated approaches require more sophisticated computation than native SPARQL can provide.
Therefore we make use of [JavaScript SPARQL Functions](https://jena.apache.org/documentation/query/javascript-functions.html) which enable processing of queried data prior to return.

However, note that this feature [requires a JavaScript engine like GraalVM](https://stackoverflow.com/questions/71413050/jena-javascript-custom-functions-scriptengine-null-error) to work.
Therefore, the `fuseki` folder in this project contains a Dockerfile which sets up a SPARQL sandbox running Fuseki server on a GraalVM runtime.
Louis has prebuilt the resultant image which is saved as a package named `fairvasc_fuseki` in this repository for fast loading.
The examples we build up here will operate by running image in multiple containers --- replicating the multiple registry setting of the real Fairvasc project --- by using internal port forwarding.
This setup enables safe sandbox development of new methods and road-testing of the GraalVM environment.

## Models

The `models` folder contains a subfolder for each standard model developed with a private counterpart supporting deployment within SPARQL using a JavaScript runtime.
The ultimate research goal is a much more general methodology, which is being developed under the EPSRC PINCODE project (joint with Gareth Roberts, Murray Pollock and Hongsheng Dai) that launches mid-2023.
In the interim, I am developing some approaches for specific models which are likely to provide rapid statistical analyses for some sample clinical questions of pertinentce to Fairvasc.

So far, we are working on:

- **Linear Regression** (`models/linreg`): this was the original example Louis produced to demonstrate proof-of-concept for federating analyses in the Fairvasc SPARQL setup.
- **Log-rank Test** (in development): idea proposed by Arthur, this is being developed as likely to provide concrete analysis results for clinically interesting questions with the simplest combination step.

## Codespaces

This repository contains a custom Github Codespaces devcontainer setup, which provides all tools required to run the examples pre-installed, together with Docker-in-Docker functionality enabling launch of a whole sandbox registry network.
Click the green "Code" button above, choose the "Codespaces" tab, and click "+" to launch a devcontainer instance which will provide a VSCode interface to the remote Github server.

*Tip for collaborators:* Make sure to register your Github account as a educational one using your institutional email at [https://education.github.com](https://education.github.com), which will get you a much larger free Codespaces quota.
