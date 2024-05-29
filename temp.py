from pathlib import Path

from json import dumps
from yaml import load

try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader

docker_compose = Path("D:/Projects/local-compose/docker-compose.yml")
def main():
    """Entry Point"""

    with docker_compose.open("r", encoding="utf-8") as f:
        data = load(f, Loader=Loader)

    services = data["services"]
    services = list(filter(
        lambda z: len(z[1]) > 0,
        map(
            lambda x: (
                x[0],
                list(filter(
                    lambda y: y.endswith(":8880"),
                    x[1].get("ports", []),
                )),
            ),
            services.items()
    )))

    for name, ports in services:
        print(" ", f"{name} = {ports[0].split(':', 1)[0]},")
    # print(dumps(services, indent=2))



if __name__ == "__main__":
    main()

