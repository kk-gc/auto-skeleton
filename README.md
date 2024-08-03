# auto-skeleton

Automatic creation of containerized ubuntu/python3/postgresql/cookiecutter/django stack

## Description

Automatic creation of containerized ubuntu/python3/postgresql/cookiecutter/django stack

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Installation

1. Clone the repository: `git clone https://github.com/kk-gc/auto-skeleton.git`
2. Navigate to the project directory: `cd auto-skeleton`
3. Optional for Linux: `sed -i -e 's/\r$//' *sh && chmod +x *sh`
4. Build docker image: `./build.sh <image-name>` or `.\bulid.bat <image-name>`
5. Create docker container: `./create.sh <image-name> <container-name>` or `.\create.bat <image-name> <container-name>`
6. Start docker container: `./start.sh <container-name>` or `.\start.bat <container-name>`
7. Navigate your web browser to: `localhost:8000`

## Usage

Navigate your web browser to: `localhost:8000`


## Contributing

TBA

## License

TBA

## Contact

TBA
