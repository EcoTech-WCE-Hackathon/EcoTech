# WCE Hackathon - EcoTech Backend

## Welcome to the Backend Repo for EcoTech

#### EcoTech is a platform for reporting E-Waste effeciently and thereby reducing the damage to the environment cauesd by the E-Waste

#### Ecotech is based on a business model which makes it sustainable both for the earth and money wise

#### We use an ML Image Classifier which can be found [here](https://github.com/EcoTech-WCE-Hackathon/EcoTech-Classifier) as a first layer filter for identification of e-waste

#### You can find the deployed version of this [here](https://eco-tech.herokuapp.com/swagger)

#### Lets get started with bringing up the backend

There are 3 ways to bring the backend up depending on the configuration you are most comfortable with

1. Directly Run The Server

2. Run the Server in a container (using Docker & Docker-Compose)

3. Run The Server inside a Kubernetes Node

### 1. Directly Run The Server :robot:

Make sure you have a startup.sh file in the root (take reference from the example.startup.sh)
or just directly execute these commands

```console
foo@bar:~$ pip install -r requirements.txt
foo@bar:~$ python manage.py makemigrations
foo@bar:~$ python manage.py migrate
foo@bar:~$ python manage.py runserver
```

This will start the server at http://localhost:8000

to create an admin user

```console
foo@bar:~$ python manage.py createsuperuser
username: foo
email: foo@bar.com
password: bar
password(again): bar
```

after that you can visit the admin panel at : https://localhost:8000/admin
If you want to get access to the api documentations go to : https://localhost:8000/swagger

<hr/>

### 2. Using Docker & Docker Compose :whale:

Make sure you have the entrypoint.sh file in the project root. (refer the example.entrypoint.sh file)

```console
foo@bar:~$ docker-compose up
```

This will start the server at [http://localhost:8000](http://localhost:8000/)
You should expect an output similar to this:
![docker-compose up](https://raw.githubusercontent.com/EcoTech-WCE-Hackathon/EcoTech-Backend/master/assets/dcu.png)

<hr/>

### 3. Using Kubernetes :snowflake:

Make sure you have the entrypoint.sh file in the project root. (refer the example.entrypoint.sh file)
Create a dev.env file (refer example.dev.env)
Make sure you have minikube installed on your system (alongside preferably docker as a driver)
Considering meet these criterias follow the steps

Give (All) Permissions to the shell scripts to execute

```console
foo@bar:~$ chmod +x orchestrate.sh
foo@bar:~$ chmod +x ip.minikube.sh
foo@bar:~$ chmod +x cluster.status.sh
foo@bar:~$ chmod +x stop_orchestrate.sh
```

Start the minikube node

```console
foo@bar:~$ minikube start
```

You should expect a similar output
![Minikube start](https://raw.githubusercontent.com/EcoTech-WCE-Hackathon/EcoTech-Backend/master/assets/minikubestart.png)

Apply Kubernetes Configs

```console
foo@bar:~$ ./orchestrate.sh
```

Check Cluster Status

```console
foo@bar:~$ ./cluster.status.sh
```

![Kube Cluster Status](https://raw.githubusercontent.com/EcoTech-WCE-Hackathon/EcoTech-Backend/master/assets/kubcluster.png)
Start Kubernetes Dashboard

```console
foo@bar:~$ minikube dashboard
```

![Kube Dash](https://raw.githubusercontent.com/EcoTech-WCE-Hackathon/EcoTech-Backend/master/assets/minikubedash.png)
Get IP Address to the Minikube Node

```console
foo@bar:~$ ./ip.minikube.sh
```

![Kube Cluster Status](https://raw.githubusercontent.com/EcoTech-WCE-Hackathon/EcoTech-Backend/master/assets/minip.png)
Open the IP in the browser
You will be able to access the server at _ip_:_port_/
You can access the swagger API Docs at /swagger
![Swagger](https://raw.githubusercontent.com/EcoTech-WCE-Hackathon/EcoTech-Backend/master/assets/livedocs.png)
Admin:
![Admin](https://raw.githubusercontent.com/EcoTech-WCE-Hackathon/EcoTech-Backend/master/assets/admin.png)
![Admin](https://raw.githubusercontent.com/EcoTech-WCE-Hackathon/EcoTech-Backend/master/assets/admin2.png)
Kubernetes Dashboard
![Admin](https://raw.githubusercontent.com/EcoTech-WCE-Hackathon/EcoTech-Backend/master/assets/kubdash.png)
Thats all, you have successfully Brought Up the server.

If you want to directly access the server, it is deployed at https://eco-tech.herokuapp.com/swagger
You can also access the Postman Collection [here](https://github.com/EcoTech-WCE-Hackathon/EcoTech/blob/master/EcoTech-Backend/EchoTech.postman_collection.json)

<hr/>

#### Finally , Thank You very much for following along.

You can visit the other services in the project [here](https://github.com/EcoTech-WCE-Hackathon/EcoTech)
Happy Coding :wink:
