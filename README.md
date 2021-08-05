[![scienceselva](https://circleci.com/gh/scienceselva/dkprojrct4.svg?style=svg)](https://app.circleci.com/pipelines/github/scienceselva/dkprojrct4)
## Project Overview

In this project, you will apply the skills you have acquired in this course to operationalize a Machine Learning Microservice API. 

You are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests your ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks

Your project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:
* Test your project code using linting
* Complete a Dockerfile to containerize this application
* Deploy your containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that your code has been tested

You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2576/view).

**The final implementation of the project will showcase your abilities to operationalize production microservices.**

---

## Setup the Environment

* Create a virtualenv and activate it
* Run `make install` to install the necessary dependencies

### Running `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`

### Kubernetes Steps

* Setup and Configure Docker locally    
* Setup and Configure Kubernetes locally
* Create Flask app in Container
* Run via kubectl

### Detailes of files in the Repository

* app.py         | the main pythin file to be run to run this app
* Dockerfile     | the file thats used for docker continer to build and run
* Makefile       | file has all the steps for the circleci integration to run ( all dependancies linting and testing)
* requirements   | all set of requirements needed to run the app
* run_docker     | for building and runnign the container locally run the script
* run_kubernetes | to runthe kubernetes cluster
* make_prediction| for running hte actual app and produce output (this is just a curl command - you can also use app like postman to test)
* upload_docker  | to upload the docker image form local to remote i.e. docker hub


### 1. Complete the Dockerfile

- Working directory
- copy cource code to / app directory
- install the requirements ( pip upgrde to make sure all commands work)
- Expose port 80
- Run app.py at container launch
  please note you can use anyone of the below (but flask runs by default on port 5000 make sure to change settings)
    - CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
    - CMD ["python", "app.py"]


To run `make lint` create and active the virtual env before:

```sh
$ make setup
$ source ~/.devops/bin/activate
$ make lint
```

### 2. Run a Container & Make a Prediction

-   Build the docker image from the Dockerfile; it is recommended that you use an optional --tag parameter as described in the build documentation.
-   List the created docker images (for logging purposes).
-   Run the containerized Flask app; publish the container’s port (`80`) to a host port (`8000`).

Run the container :

```sh
$ . ./run_docker.sh
```

Run the prediction script:

```sh
$ . ./make_prediction.sh 
```

### 3. Improve Logging & Save Output

-   Add a prediction log statement
-   Run the container and make a prediction to check the logs

you should see a output like below sample

```sh
 * Debug mode: on
 * Running on http://0.0.0.0:80/ (Press CTRL+C to quit)
 * Restarting with stat
 * Debugger is active!
 * Debugger PIN: 235-900-666
[2021-08-04 11:55:56,507] INFO in app: JSON payload:
{'CHAS': {'0': 0}, 'RM': {'0': 6.575}, 'TAX': {'0': 296.0}, 'PTRATIO': {'0': 15.3}, 'B': {'0': 396.9}, 'LSTAT': {'0': 4.98}}
[2021-08-04 11:55:56,532] INFO in app: Inference payload DataFrame:
   CHAS     RM    TAX  PTRATIO      B  LSTAT
0     0  6.575  296.0     15.3  396.9   4.98
[2021-08-04 11:55:56,551] INFO in app: Scaling Payload:
   CHAS     RM    TAX  PTRATIO      B  LSTAT
0     0  6.575  296.0     15.3  396.9   4.98
[2021-08-04 11:55:56,559] INFO in app: Prediction:
[20.35373177134412]
172.17.0.1 - - [04/Aug/2021 11:55:56] "POST /predict HTTP/1.1" 200 -
```
* same is avaialbe in output_txt_files folder

### 4. Upload the Docker Image

-   Create a [Docker Hub](https://hub.docker.com/) account
-   Built the docker container with this command `docker build --tag=<your_tag> .` **(Don't forget the tag name)**
-   Define a `dockerpath` which is `<docker_hub_username>/<project_name>` e.g: `minorpath/kubernetes-p4`
-   Authenticate and tag image
-   Push your docker image to the `dockerpath`

in some case the tagging will not work inthe first step pleas euse as below in push statement to tag
docker push $dockerpath:mlapp    [ mlapp - to be replaced with your tag name]

upload to docker hub script:

```sh
$ . ./upload_docker.sh
```

### 5. Configure Kubernetes to Run Locally

-   [Install Kubernetes](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux)
-   [Install Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)


### 6. Deploy with Kubernetes and Save Output Logs

-   Define a dockerpath which will be `<docker_hub_username>/<project_name>`, this should be the same name as your uploaded repository (the same as in upload_docker.sh)
-   Run the docker container with kubectl; you’ll have to specify the container and the port
-   List the kubernetes pods
-   Forward the container port to a host port, using the same ports as before


run kubectl script :

```sh
$ . ./run_kubernetes.sh
```
* now we can make predction again buy followin whats in step 3

### 7. Delete Cluster

If you want to delete the kubernetes cluster just run this command `minikube delete`. You can also stop the kubernetes cluster with this command `minikube stop`

### 8. CircleCI Integration

-   Create a [CircleCI Account](https://circleci.com/) 

-   We can create a config file while setting up the project in circle ci 
OR
-   Create a config manually sample here -> [template](https://raw.githubusercontent.com/udacity/DevOps_Microservices/master/Lesson-2-Docker-format-containers/class-demos/.circleci/config.yml)

-   Add a status badge using this template: as given in the page in [CircleCI documentation] (https://circleci.com/docs/2.0/status-badges/)

--> additionally testing is also added in make file and circle ci step