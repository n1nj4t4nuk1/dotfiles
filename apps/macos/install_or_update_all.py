import argparse
import os
import socket

if __name__ == "__main__":
    # Parse the arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('-m', '--mode', type=str)
    parser.add_argument('-d', '--device', type=str, default=socket.gethostname().split('.')[0], 
                       help='Device name (defaults to current hostname)')
    args = parser.parse_args()
    mode = args.mode
    device = args.device
    dfox_path = os.getenv("DFOX_PATH")

    # Path to the packages file
    pkgs_file_path  = f"{dfox_path}/apps/macos/{device}/homebrew/packages.txt"
    apps_file_path  = f"{dfox_path}/apps/macos/{device}/homebrew/applications.txt"
    casks_file_path = f"{dfox_path}/apps/macos/{device}/homebrew/casks.txt"

    packages, apps, casks = [], [], []

    print(f"Using device configuration: {device}")

    for file_path in [pkgs_file_path, apps_file_path, casks_file_path]:
        if not os.path.isfile(file_path):
            print(f"The file {file_path} does not exist.")
            exit(1)

    # Read the file and get the list of packages
    with open(pkgs_file_path, "r") as file:
        packages = [line.strip() for line in file if line.strip()]

    # Read the file and get the list of packages
    with open(casks_file_path, "r") as file:
        casks = [line.strip() for line in file if line.strip()]

    # Read the file and get the list of packages
    with open(apps_file_path, "r") as file:
        apps = [line.strip() for line in file if line.strip()]

    # Install each package using brew
    for package in packages:
        print(f"{'Installing' if mode == 'install' else 'Updating'} package {package}...")
        os.system(f"brew {'install' if mode == 'install' else 'upgrade'} {package}")
        print(f"Package {package} {'installed' if mode == 'install' else 'updated'} .")

    # Install each cask using brew
    for cask in casks:
        print(f"{'Installing' if mode == 'install' else 'Updating'} cask {cask}...")
        os.system(f"brew {'install' if mode == 'install' else 'upgrade'} {cask}")
        print(f"Cask {cask} {'installed' if mode == 'install' else 'updated'} .")

    # Install each application using mas
    os.system("mas upgrade")
