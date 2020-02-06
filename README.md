# CI / CD Workflow for a Rails + Docker app

This is a start-to-finish walkthrough on how to assemble and deploy a Ruby on Rails (6.0.2) application on the cloud provider DigitalOcean using Docker and GitLab CI/CD. Both the application and its PostgreSQL database are coordinated by docker-compose inside a Docker engine that lives in a DigitalOcean virtual environment called a “droplet”. To give it a real-world use-case, the app pulls data from the Oura Ring Sleep tracker API and visualizes it with Python libraries.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

You need [Docker Engine](https://docs.docker.com/install/) installed locally, and a [GitLab](http://gitlab.com/) account.

### Installing

`docker-compose up --build`

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please feel free to contact me for details on our code of conduct, and the process for submitting pull requests.

## Authors

* **Plinio Guzman** - *Initial work* - [mindatasleep](https://github.com/mindatasleep)

## License

This project is licensed under the MIT License. 

## Acknowledgments

* Hat tip to contributors cited across the article for sharing with the community. 
