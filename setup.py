import os
import zipfile
import subprocess
import platform
import requests
from sys import argv
from shutil import which,rmtree
from typing import Callable
from pathlib import Path

class Tool:
    def __init__(self, name: str, install: Callable[[], str]) -> None:
        self.name = name
        self._install_ = install
        self._path_ = name

    def exists(self) -> bool:
        return which(self.name) is not None

    def install(self):
        self._path_ = self._install_()

    def run(self, *args: str) -> subprocess.CompletedProcess[bytes]:
        return subprocess.run([self._path_, *args])

def install_rust() -> str:
    print("\x1b[1mInstalling Rustup\x1b[0m")
    match platform.system():
        case "Windows":
            response = requests.get(
                "https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe",
                stream=True
            )

            installer_path = Path(__file__).parent.joinpath("rustup-init.exe")
            with installer_path.open("+wb") as file:
                for chunk in response.iter_content(chunk_size=8192):
                    file.write(chunk)

            # Run installer
            subprocess.run([installer_path], shell=True)

            # Remove installer
            rmtree(installer_path, True)
            return str(Path.home().joinpath(".cargo", "bin", "cargo.exe"))
        case _:
            result = subprocess.run(["curl", "--proto", "=https", "--tlsv1.2", "-sSf", "https://sh.rustup.rs"], capture_output=True)
            installer_path = Path(__file__).parent.joinpath("rustInstall.sh")
            with installer_path.open("+w") as file:
                file.write(result.stdout.decode().strip())
            subprocess.run([installer_path])
            os.remove(installer_path)
            return str(Path.home().joinpath(".cargo", "bin", "cargo"))

def install_n() -> str:
    print("\x1b[1mInstalling Node\x1b[0m")
    match platform.system():
        case "Windows":
            response = requests.get(
                "https://github.com/nodists/nodist/releases/download/v0.10.3/NodistSetup-0.10.3.exe",
                stream=True
            )

            installer_path = Path(__file__).parent.joinpath("NodistSetup-0.10.3.exe")
            with installer_path.open("+wb") as file:
                for chunk in response.iter_content(chunk_size=8192):
                    file.write(chunk)

            # Run installer
            subprocess.run([installer_path], shell=True)

            # Remove installer
            rmtree(installer_path, True)

            subprocess.run([
                    'set',
                    'NODE_TLS_REJECT_UNAUTHORIZED=0',
                    '&&',
                    "C:\\Program Files (x86)\\Nodist\\bin\\nodist.ps1",
                    "latest"
                ],
                shell=True
            )

            return str(Path("C:\\Program Files (x86)\\Nodist\\bin\\npm.exe"))
        case _:
            subprocess.run([
                "curl","-fsSL","https://raw.githubusercontent.com/tj/n/master/bin/n","|","bash","-s","install","lts"
            ])
            subprocess.run(["npm", "install", "-g", "n"])
            return str(Path("/usr/local/bin/npm"))

def install_fzf():
    print("Select a path where fzf will be cloned")
    path = input("(default: ~/.fzf) > ")

    if len(path):
        path = Path(path.replace('~', str(Path.home())))
    else:
        path = Path.home().joinpath(".fzf")

    subprocess.run(["git", "clone", "--depth", "1", "https://github.com/junegunn/fzf.git", path])

    match platform.system():
        case "Windows":
            subprocess.run(["powershell", "-File", path.joinpath("install.ps1")])
        case _:
            subprocess.run([path.joinpath('install')])

def executable(base: Path, name: str) -> Path:
    if base.joinpath(name).exists():
        return base.joinpath("name")
    else:
        return base.joinpath(f"{name}.exe")

def dependencies():
    cargo = Tool("cargo", install_rust)
    npm = Tool("npm", install_n)

    if not cargo.exists():
        cargo.install()

    if not npm.exists():
        npm.install()

    if which("bob") is None:
        cargo.run("install", "bob-nvim")
    if which("nvim") is None:
        subprocess.run([Path.home().joinpath(".cargo", "bin", "bob"), "install", "latest"])
        match platform.system():
            case "Windows":
                print(f"Add {Path.home().joinpath('AppData', 'Local', 'bob', 'nvim-bin')}")
            case _:
                print(f"Add {Path.home().joinpath('.local', 'share', 'bob', 'nvim-bin')}")
    if which("rg") is None:
        cargo.run("install", "ripgrep")
    if which("fd") is None:
        cargo.run("install", "fd-find")

    if which("fzf") is None:
        install_fzf()

    if subprocess.run(["npm", "list", "--depth", "1", "--global", "@vue/typescript-plugin"], capture_output=True).returncode != 0:
        npm.run("install", "-g", "@vue/typescript-plugin")

    print("Restart your shell to get access to all newly installed dependencies")
    print()
    print("If you plan to run this script again make sure to always restart your shell to make sure any new items in your path are picked up")

def treesitter():
    url = "https://github.com/anasrar/nvim-treesitter-parser-bin/releases/download/linux/all.zip"
    path = Path.home().joinpath(".local", "share", "nvim", "lazy", "nvim-treesitter")
    filename = "all-linux.zip"
    if platform.system() == "Windows":
        url = "https://github.com/anasrar/nvim-treesitter-parser-bin/releases/download/windows/all.zip"
        path = Path.home().joinpath("AppData", "Local", "nvim-data")
        filename = "all-windows.zip"

    if path.exists():
        if path.joinpath("parser").exists():
            rmtree(path.joinpath("parser"))
        os.mkdir(path.joinpath("parser"))

        response = requests.get(url, stream=True)

        zip_path = Path(__file__).parent.joinpath(filename)
        with zip_path.open("+wb") as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            zip_ref.extractall(path.joinpath("parser"))
    else:
        print("failed to download precompiled treesitter binaries")
        return

def main(command):
    missing = []

    if which("git") is None:
        missing.append("git")
        
    match platform.system():
        case "Windows": pass
        case _:
            if which("cc") is None:
                print("Missing dependency `cc`; maybe try `sudo apt install build-essential`")
                missing.append("cc")
            if which("zip") is None:
                missing.append("zip")
            if which("unzip") is None:
                missing.append("unzip")

    if len(missing):
        raise Exception(f"missing user provided dependencies: {missing}")

    match command:
        case "deps":
            dependencies()
        case "ts":
            treesitter()
        case _:
            print("unknown command", command)

if __name__ == "__main__":
    command = None
    if len(argv) > 1:
        command = argv[1]
    main(command)
