
---

### 📄 `README.md` – High-Level Overview for PX4 Dev Environment

```markdown
# PX4 Development Environment (DevContainer + Docker)

This repository sets up a portable, reproducible development environment for the [PX4-Autopilot](https://github.com/PX4/PX4-Autopilot) flight stack using Docker and Visual Studio Code DevContainers.

✅ No need to install toolchains on your host  
✅ Works identically across Linux, macOS, and WSL  
✅ Supports Gazebo, PX4 SITL, and Git-based workflow

---

## 🛠️ Requirements

* Docker (>= 20.10)
* VSCode + Remote Containers extension
* X11 support (Linux) for Gazebo GUI

---

## 📁 Repository Structure

```

px4-dev-env/
├── PX4-Autopilot/        # PX4 source code (cloned or submodule)
├── docker/               # Dockerfile for PX4 build environment
├── .devcontainer/        # VSCode dev container configuration
├── Makefile              # Helper CLI commands
└── README.md             # This file

````

---

## 🚀 Quick Start

### 1. Clone the Repo

```bash
git clone https://github.com/PX4/PX4-Autopilot.git --recursive
mkdir px4-dev-env && cd px4-dev-env
mv ../PX4-Autopilot .
````

Or, if using as a Git submodule:

```bash
git submodule add https://github.com/PX4/PX4-Autopilot.git
git submodule update --init --recursive
```

---

### 2. Build the Docker Image

```bash
make docker-build
```

This uses the Dockerfile inside `docker/` to install all PX4 and Gazebo dependencies.

---

### 3. Launch in VSCode

* Open this folder in VSCode:

```bash
code .
```

* Run: `F1` → `Remote-Containers: Reopen in Container`

VSCode will:

* Build the image (if needed)
* Launch the container
* Mount PX4-Autopilot for development

---

### 4. Build PX4

In the VSCode terminal:

```bash
cd /workspaces/PX4-Autopilot
make px4_sitl_default
```

To test in Gazebo:

```bash
make px4_sitl_default gazebo
```

---

## 🔁 Git Workflow

### Use Git normally from inside the container:

```bash
cd /workspaces/PX4-Autopilot
git checkout -b my-feature
# make changes
git add .
git commit -m "Add new feature"
git push origin my-feature
```
---

## 💡 Why Use DevContainers?

* Reproducible builds across devs/CI
* Fully configured toolchain
* Works with VSCode's IntelliSense & debugger
* Easy Git integration
* Gazebo + GUI support via X11

---

## ✅ Next Steps

* Add missions or custom PX4 modules
* Use GitHub Actions with same Dockerfile
* Extend this to run PX4 on real hardware

---

Happy flying! ✈️
Maintainer: Darshan K T


